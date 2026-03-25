from fastapi import HTTPException
from sqlalchemy.orm import Session
from api import schemas
from api.services import query, seances

async def get_all_seance_exos_for_seance(seance_id: int, db: Session, user_email: str):
    # Verify the seance belongs to the user
    await seances.get_seance_by_id(seance_id, db, user_email)
    
    req = schemas.GenericQueryRequest(
        table_name="seance_exo",
        columns=["id_seance_exo", "id_seance", "id_exercice", "daily_1rm"],
        conditions={"id_seance": seance_id}
    )
    return await query.execute_generic_query(req, db)

async def get_seance_exo_by_id(id_seance_exo: int, db: Session, user_email: str):
    # Retrieve the seance_exo to verify it exists
    req = schemas.GenericQueryRequest(
        table_name="seance_exo",
        columns=["id_seance_exo", "id_seance", "id_exercice", "daily_1rm"],
        conditions={"id_seance_exo": id_seance_exo}
    )
    results = await query.execute_generic_query(req, db)
    if not results:
        raise HTTPException(status_code=404, detail="Seance_exo non trouvé")
    seance_exo = results[0]
    
    # Verify the associated seance belongs to the user
    await seances.get_seance_by_id(seance_exo["id_seance"], db, user_email)
    
    return seance_exo

async def create_seance_exo(seance_exo: schemas.SeanceExoCreate, db: Session, user_email: str):
    # Verify the seance belongs to the user
    await seances.get_seance_by_id(seance_exo.id_seance, db, user_email)
    
    create_req = schemas.GenericCreateRequest(
        table_name="seance_exo",
        data={
            "id_seance": seance_exo.id_seance,
            "id_exercice": seance_exo.id_exercice,
            "daily_1rm": seance_exo.daily_1rm
        }
    )
    result = await query.execute_generic_create(create_req, db)
    if result:
        return {"message": "Exercice ajouté à la séance avec succès", "id_seance": seance_exo.id_seance}
    raise HTTPException(status_code=500, detail="Échec de l'ajout de l'exercice à la séance")

async def update_seance_exo(id_seance_exo: int, seance_exo_update: schemas.SeanceExoUpdate, db: Session, user_email: str):
    await get_seance_exo_by_id(id_seance_exo, db, user_email)
    
    updates = seance_exo_update.model_dump(exclude_unset=True)
    if not updates:
        return await get_seance_exo_by_id(id_seance_exo, db, user_email)
        
    update_req = schemas.GenericUpdateRequest(
        table_name="seance_exo",
        updates=updates,
        conditions={"id_seance_exo": id_seance_exo}
    )
    await query.execute_generic_update(update_req, db)
    return await get_seance_exo_by_id(id_seance_exo, db, user_email)

async def delete_seance_exo(id_seance_exo: int, db: Session, user_email: str):
    await get_seance_exo_by_id(id_seance_exo, db, user_email)
    
    delete_req = schemas.GenericDeleteRequest(
        table_name="seance_exo",
        conditions={"id_seance_exo": id_seance_exo}
    )
    await query.execute_generic_delete(delete_req, db)
    return {"message": "Seance_exo supprimé avec succès"}
