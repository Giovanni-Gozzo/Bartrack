from fastapi import HTTPException
from sqlalchemy.orm import Session
from api import schemas
from api.services import query, users
from datetime import datetime, timedelta
from api.database import engine, metadata
from sqlalchemy import Table, select, and_
from sklearn.linear_model import LinearRegression
import numpy as np

async def initialize_profile(payload: schemas.InitRequest, db: Session, user_email: str):
    # Fetch user ID
    user = await users.get_user_by_email(user_email, db)
    user_id = int(user["id_utilisateur"])

    rpe_low = payload.rpe_low
    rpe_high = payload.rpe_high
    v_low = payload.speed_low
    v_high = payload.speed_high

    if rpe_high <= rpe_low:
        raise HTTPException(status_code=400, detail="rpe_high doit être strictement supérieur à rpe_low.")
    if v_low <= 0 or v_high <= 0:
        raise HTTPException(status_code=400, detail="Les vitesses doivent être strictement positives.")
    if v_high > v_low:
        raise HTTPException(status_code=400, detail="v_high doit être strictement inférieur à v_low.")

    slope = (rpe_high - rpe_low) / (v_high - v_low)
    intercept = rpe_high - slope * v_high


    try:
        req = schemas.GenericUpdateRequest(
            table_name="profil_vbt",
            updates={
                "slope": slope,
                "intercept": intercept
            },
            conditions={
                "id_utilisateur": user_id,
                "id_exercice": int(payload.idexercice)
            }
        )
        await query.execute_generic_update(req, db)
    except Exception as e:
        print(f"Erreur update DB: {e}")

    return {
        "slope": slope,
        "intercept": intercept,
        "inputs": {
            "rpe_low": rpe_low,
            "rpe_high": rpe_high,
            "speed_low": v_low,
            "speed_high": v_high,
            "idutilisateur": user_id,
            "idexercice": payload.idexercice
        },
    }

async def calculate_rpe(payload: schemas.ComputeRpeRequest, db: Session, user_email: str):
    # Fetch user ID
    user = await users.get_user_by_email(user_email, db)
    user_id = int(user["id_utilisateur"])

    slope = 0.0
    intercept = 0.0

    try:
        req = schemas.GenericQueryRequest(
            table_name="profil_vbt",
            columns=["slope", "intercept"],
            conditions={
                "id_utilisateur": user_id,
                "id_exercice": int(payload.idexercice)
            }
        )
        data = await query.execute_generic_query(req, db)
        if data:
            slope = float(data[0]["slope"])
            intercept = float(data[0]["intercept"])
    except Exception as e:
        print(f"Erreur recup slope/intercept: {e}")

    rpe = slope * payload.speed + intercept

    return {
        "rpe": rpe, 
        "inputs": {
            "speed": payload.speed, 
            "slope": slope, 
            "intercept": intercept,
            "idutilisateur": user_id,
            "idexercice": payload.idexercice
        }
    }

async def calculate_daily_1rm(payload: schemas.Daily1rmRequest, db: Session, user_email: str):
    # 1. Fetch User
    user = await users.get_user_by_email(user_email, db)
    user_id = int(user["id_utilisateur"])
 
    # 2. Récupérer le 1RM Actuel (Historique)
    RM1 = 0.0
    try:
        req = schemas.GenericQueryRequest(
            table_name="profil_vbt",
            columns=["current_1rm"],
            conditions={"id_utilisateur": user_id, "id_exercice": int(payload.idexercice)}
        )
        data = await query.execute_generic_query(req, db)
        if data:
            RM1 = float(data[0]["current_1rm"])
    except Exception as e:
        print(f"Erreur recup 1RM: {e}")
        return {"error": "Impossible de récupérer le 1RM"}
 
    # 3. Calcul du RPE Réel (Via Vitesse)
    # On délègue à ta fonction existante
    payload_rpe = schemas.ComputeRpeRequest(
        idexercice=payload.idexercice,
        speed=payload.vitesse
    )
    rpe_result = await calculate_rpe(payload_rpe, db, user_email)
    rpe_reel_brut = float(rpe_result["rpe"])
    # 4. Arrondi du RPE Réel pour matcher la Table de Référence
    # On arrondit au 0.5 le plus proche (ex: 8.2 -> 8.0, 8.4 -> 8.5)
    rpe_reel_rounded = round(rpe_reel_brut * 2) / 2
    # Sécurité : On borne entre 6.5 et 10 (limites usuelles du tableau)
    rpe_reel_rounded = max(6.5, min(10.0, rpe_reel_rounded))
 
    # 5. Récupérer le Pourcentage correspondant à ce RPE/Reps RÉEL
    # On cherche : "A 3 reps pour RPE 8.5 (réel), ça vaut combien de % ?"
    pourcentage_reel = 0.0
    try:
        req = schemas.GenericQueryRequest(
            table_name="ref_rpe_table",
            columns=["percentage"],
            conditions={
                "rpe": rpe_reel_rounded,
                "reps": payload.nbrep
            }
        )
        data = await query.execute_generic_query(req, db)
        if data:
            pourcentage_reel = float(data[0]["percentage"])
    except Exception as e:
        print(f"Erreur recup pourcentage: {e}")
 
    # 6. Calcul du Daily 1RM (La règle de trois)
    # Si j'ai soulevé 90kg et que ça valait 89% (RPE 9), alors 100% = 90 / 0.89
    rm_daily = RM1 # Par défaut
    if pourcentage_reel > 0:
        rm_daily = payload.poidsbarre / pourcentage_reel
 
    # 7. Comparaison pour le feedback (Optionnel mais cool pour le front)
    # On calcule l'écart en %
    variation = ((rm_daily - RM1) / RM1) * 100
 
    return {
        "rmdaily": round(rm_daily, 2),
        "rm_historique": RM1,
        "variation_percent": round(variation, 1),
        "debug": {
            "rpe_reel_mesure": rpe_reel_brut,
            "rpe_reel_arrondi": rpe_reel_rounded,
            "pourcentage_utilise": pourcentage_reel
        }
    }

    
    
    
async def calculate_weight(payload: schemas.PoidsRPE, db: Session, user_email: str):
    # Fetch user ID
    user = await users.get_user_by_email(user_email, db)
    user_id = int(user["id_utilisateur"])    
    pourcentage = 0.0
    try:
        req = schemas.GenericQueryRequest(
            table_name="ref_rpe_table",
            columns=["percentage"],
            conditions={
                "rpe": payload.rpe,
                "reps": payload.nbrep
            }
        )
        data = await query.execute_generic_query(req, db)
        if data:
            pourcentage = float(data[0]["percentage"])
    except Exception as e:
        print(f"Erreur recup pourcentage: {e}")
        pourcentage = 0.0

    print(f"RM1: {payload.RM1}, pourcentage: {pourcentage}")
    poids = pourcentage * payload.RM1
    
    return {
        "poids": poids, 
        "inputs": {
            "rpe": payload.rpe,
            "nbrep": payload.nbrep,
            "idutilisateur": user_id,
            "idexercice": payload.idexercice
        }
    }

async def compute_rolling_vbt_profile(payload: schemas.RollingCalculationRequest, db: Session, user_email: str):
    # Fetch user ID
    user = await users.get_user_by_email(user_email, db)
    user_id = int(user["id_utilisateur"])
    
    # Load tables safely
    try:
        seance = Table("seance", metadata, autoload_with=engine)
        seance_exo = Table("seance_exo", metadata, autoload_with=engine)
        serie = Table("serie", metadata, autoload_with=engine)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database metadata error: {str(e)}")
    
    # Calculate date 30 days ago
    date_30_days_ago = datetime.now() - timedelta(days=30)
    
    # Build query
    stmt = (
        select(serie.c.vitesse_fin_serie, serie.c.rpe_reel)
        .select_from(
            serie.join(seance_exo, serie.c.id_seance_exo == seance_exo.c.id_seance_exo)
                 .join(seance, seance_exo.c.id_seance == seance.c.id_seance)
        )
        .where(
            and_(
                seance.c.id_utilisateur == user_id,
                seance_exo.c.id_exercice == payload.id_exercice,
                seance.c.date_seance >= date_30_days_ago.date(),
                serie.c.echauffement == False,
                serie.c.vitesse_fin_serie != None,
                serie.c.vitesse_fin_serie > 0,
                serie.c.rpe_reel != None
            )
        )
    )
    
    # Execute query
    result = db.execute(stmt).all()
    
    if len(result) < 2:
        return {
            "status": "skipped",
            "message": "Pas assez de données valides sur les 30 derniers jours (minimum 2 séries requises).",
            "data_points": len(result)
        }
        
    # Extract X (Vitesse) and y (RPE)
    # sklearn expects X as a 2D array, e.g. [[0.85], [0.82], ...]
    X = np.array([float(r.vitesse_fin_serie) for r in result]).reshape(-1, 1)
    y = np.array([float(r.rpe_reel) for r in result])
    
    # Compute Linear Regression
    model = LinearRegression()
    model.fit(X, y)
    
    nouvelle_slope = float(model.coef_[0])
    nouvel_intercept = float(model.intercept_)
    
    # Update PROFIL_VBT
    try:
        # Check if exists
        req_check = schemas.GenericQueryRequest(
            table_name="profil_vbt",
            columns=["id_utilisateur"],
            conditions={"id_utilisateur": user_id, "id_exercice": payload.id_exercice}
        )
        existing = await query.execute_generic_query(req_check, db)
        
        now_iso = datetime.now().isoformat()
        if existing:
            # Update
            update_req = schemas.GenericUpdateRequest(
                table_name="profil_vbt",
                updates={
                    "slope": nouvelle_slope,
                    "intercept": nouvel_intercept,
                    "last_updated": now_iso
                },
                conditions={"id_utilisateur": user_id, "id_exercice": payload.id_exercice}
            )
            await query.execute_generic_update(update_req, db)
        else:
            # Create
            create_req = schemas.GenericCreateRequest(
                table_name="profil_vbt",
                data={
                    "id_utilisateur": user_id,
                    "id_exercice": payload.id_exercice,
                    "slope": nouvelle_slope,
                    "intercept": nouvel_intercept,
                    "last_updated": now_iso
                }
            )
            await query.execute_generic_create(create_req, db)
            
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erreur lors de la mise à jour du profil VBT: {str(e)}")
        
    return {
        "status": "success",
        "message": "Profil VBT mis à jour avec le Rolling Calculation 30 jours.",
        "data_points": len(result),
        "new_slope": round(nouvelle_slope, 4),
        "new_intercept": round(nouvel_intercept, 4)
    }

