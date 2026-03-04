from fastapi import HTTPException
from sqlalchemy.orm import Session
from api import schemas
from api.services import query, users

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
    # Fetch user ID
    user = await users.get_user_by_email(user_email, db)
    user_id = int(user["id_utilisateur"])

    
    RM1 = 0.0
    #1rm actuel
    try:
        req = schemas.GenericQueryRequest(
            table_name="profil_vbt",
            columns=["current_1rm"],
            conditions={
                "id_utilisateur": user_id,
                "id_exercice": int(payload.idexercice)
            }
        )
        data = await query.execute_generic_query(req, db)
        if data:
            RM1 = float(data[0]["current_1rm"])
    except Exception as e:
        print(f"Erreur recup 1RM: {e}")
    
    intensity = payload.poidsbarre / RM1 if RM1 > 0 else 0.0

    rpetheorique = 0.0
    #rpe théorique
    if intensity > 0:
        try:
            req = schemas.GenericQueryRequest(
                table_name="ref_rpe_table",
                columns=["rpe"],
                conditions={
                    "percentage": intensity,
                    "reps": payload.nbrep
                }
            )
            data = await query.execute_generic_query(req, db)
            if data:
                rpetheorique = float(data[0]["rpe"])
        except Exception as e:
            print(f"Erreur recup rpetheorique: {e}")
    
    #rpe reel
    payload_rpe = schemas.ComputeRpeRequest(
        idexercice=payload.idexercice,
        speed=payload.vitesse
    )
    rperéel = await calculate_rpe(payload_rpe, db, user_email)

    rmdaily = RM1
    if rperéel["rpe"] > rpetheorique :
        try:
            req = schemas.GenericQueryRequest(
                table_name="ref_rpe_table",
                columns=["percentage"],
                conditions={
                    "rpe": rperéel["rpe"],
                    "reps": payload.nbrep
                }
            )
            data = await query.execute_generic_query(req, db)
            if data:
                pourcentage = float(data[0]["percentage"])
        except Exception as e:
            print(f"Erreur recup pourcentage: {e}")
            pourcentage = 0.0
        rmdaily = payload.poidsbarre / pourcentage
            
    return {
        "rmdaily": rmdaily,
        "inputs": {
            "rpe": rperéel["rpe"],
            "nbrep": payload.nbrep,
            "idutilisateur": user_id,
            "idexercice": payload.idexercice
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
