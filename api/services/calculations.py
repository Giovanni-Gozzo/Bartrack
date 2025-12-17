from fastapi import HTTPException
from sqlalchemy.orm import Session
from api import schemas
from api.services.query import execute_generic_query

async def initialize_profile(payload: schemas.InitRequest):
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
                "id_utilisateur": payload.idutilisateur,
                "id_exercice": payload.idexercice
            }
        )
        await execute_generic_update(req, db)
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
            "idutilisateur": payload.idutilisateur,
            "idexercice": payload.idexercice
        },
    }

async def calculate_rpe(payload: schemas.ComputeRpeRequest, db: Session):

    slope = 0.0
    intercept = 0.0

    try:
        req = schemas.GenericQueryRequest(
            table_name="profil_vbt",
            columns=["slope", "intercept"],
            conditions={
                "id_utilisateur": payload.idutilisateur,
                "id_exercice": payload.idexercice
            }
        )
        data = await execute_generic_query(req, db)
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
            "idutilisateur": payload.idutilisateur,
            "idexercice": payload.idexercice
        }
    }

async def calculate_weight(payload: schemas.PoidsRPE, db: Session):
    RM1 = 0.0
    try:
        req = schemas.GenericQueryRequest(
            table_name="profil_vbt",
            columns=["current_1rm"],
            conditions={
                "id_utilisateur": payload.idutilisateur,
                "id_exercice": payload.idexercice
            }
        )
        data = await execute_generic_query(req, db)
        if data:
            RM1 = float(data[0]["current_1rm"])
    except Exception as e:
        print(f"Erreur recup 1RM: {e}")
        RM1 = 0.0
    
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
        data = await execute_generic_query(req, db)
        if data:
            pourcentage = float(data[0]["percentage"])
    except Exception as e:
        print(f"Erreur recup pourcentage: {e}")
        pourcentage = 0.0

    print(f"RM1: {RM1}, pourcentage: {pourcentage}")
    poids = pourcentage * RM1
    
    return {
        "poids": poids, 
        "inputs": {
            "rpe": payload.rpe,
            "nbrep": payload.nbrep,
            "idutilisateur": payload.idutilisateur,
            "idexercice": payload.idexercice
        }
    }
