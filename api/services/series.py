from fastapi import HTTPException
from sqlalchemy.orm import Session
from api import schemas
from api.services import query, seance_exos

async def get_all_series_for_seance_exo(id_seance_exo: int, db: Session, user_email: str):
    # Verify access to the parent seance_exo
    await seance_exos.get_seance_exo_by_id(id_seance_exo, db, user_email)
    
    req = schemas.GenericQueryRequest(
        table_name="serie",
        columns=["id", "id_seance_exo", "charge_kg", "nombre_reps", "vitesse_fin_serie", "rpe_estime", "rpe_reel", "echauffement"],
        conditions={"id_seance_exo": id_seance_exo}
    )
    return await query.execute_generic_query(req, db)

async def get_serie_by_id(id_serie: int, db: Session, user_email: str):
    req = schemas.GenericQueryRequest(
        table_name="serie",
        columns=["id", "id_seance_exo", "charge_kg", "nombre_reps", "vitesse_fin_serie", "rpe_estime", "rpe_reel", "echauffement"],
        conditions={"id": id_serie}
    )
    results = await query.execute_generic_query(req, db)
    if not results:
        raise HTTPException(status_code=404, detail="Série non trouvée")
    serie = results[0]
    
    # Verify access to the parent seance_exo
    await seance_exos.get_seance_exo_by_id(serie["id_seance_exo"], db, user_email)
    
    return serie

async def create_serie(serie: schemas.SerieCreate, db: Session, user_email: str):
    await seance_exos.get_seance_exo_by_id(serie.id_seance_exo, db, user_email)
    
    create_req = schemas.GenericCreateRequest(
        table_name="serie",
        data={
            "id_seance_exo": serie.id_seance_exo,
            "charge_kg": serie.charge_kg,
            "nombre_reps": serie.nombre_reps,
            "vitesse_fin_serie": serie.vitesse_fin_serie,
            "rpe_estime": serie.rpe_estime,
            "rpe_reel": serie.rpe_reel,
            "echauffement": serie.echauffement
        }
    )
    result = await query.execute_generic_create(create_req, db)
    if result:
        return {"message": "Série créée avec succès"}
    raise HTTPException(status_code=500, detail="Échec de la création de la série")

async def update_serie(id_serie: int, serie_update: schemas.SerieUpdate, db: Session, user_email: str):
    await get_serie_by_id(id_serie, db, user_email)
    
    updates = serie_update.model_dump(exclude_unset=True)
    if not updates:
        return await get_serie_by_id(id_serie, db, user_email)
        
    update_req = schemas.GenericUpdateRequest(
        table_name="serie",
        updates=updates,
        conditions={"id": id_serie}
    )
    await query.execute_generic_update(update_req, db)
    return await get_serie_by_id(id_serie, db, user_email)

async def delete_serie(id_serie: int, db: Session, user_email: str):
    await get_serie_by_id(id_serie, db, user_email)
    
    delete_req = schemas.GenericDeleteRequest(
        table_name="serie",
        conditions={"id": id_serie}
    )
    await query.execute_generic_delete(delete_req, db)
    return {"message": "Série supprimée avec succès"}
