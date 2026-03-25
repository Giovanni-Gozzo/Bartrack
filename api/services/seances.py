from fastapi import HTTPException
from sqlalchemy.orm import Session
from api import schemas
from api.services import query, users

async def get_all_seances(db: Session, user_email: str):
    # Only return seances of current user
    user = await users.get_user_by_email(user_email, db)
    user_id = int(user["id_utilisateur"])
    req = schemas.GenericQueryRequest(
        table_name="seance",
        columns=["id_seance", "id_utilisateur", "date_seance"],
        conditions={"id_utilisateur": user_id}
    )
    return await query.execute_generic_query(req, db)

async def get_seance_by_id(seance_id: int, db: Session, user_email: str):
    user = await users.get_user_by_email(user_email, db)
    user_id = int(user["id_utilisateur"])
    
    req = schemas.GenericQueryRequest(
        table_name="seance",
        columns=["id_seance", "id_utilisateur", "date_seance"],
        conditions={"id_seance": seance_id, "id_utilisateur": user_id}
    )
    seances_found = await query.execute_generic_query(req, db)
    if not seances_found:
        raise HTTPException(status_code=404, detail="Séance non trouvée ou accès non autorisé")
    return seances_found[0]

async def create_seance(seance: schemas.SeanceCreate, db: Session, user_email: str):
    user = await users.get_user_by_email(user_email, db)
    user_id = int(user["id_utilisateur"])
    
    create_req = schemas.GenericCreateRequest(
        table_name="seance",
        data={"id_utilisateur": user_id, "date_seance": seance.date_seance}
    )
    result = await query.execute_generic_create(create_req, db)
    if result:
        return {"message": "Séance créée avec succès", "date_seance": seance.date_seance}
    raise HTTPException(status_code=500, detail="Failed to create seance")

async def update_seance(seance_id: int, seance_update: schemas.SeanceUpdate, db: Session, user_email: str):
    await get_seance_by_id(seance_id, db, user_email)
    
    updates = seance_update.model_dump(exclude_unset=True)
    if not updates:
        return await get_seance_by_id(seance_id, db, user_email)
        
    update_req = schemas.GenericUpdateRequest(
        table_name="seance",
        updates=updates,
        conditions={"id_seance": seance_id}
    )
    await query.execute_generic_update(update_req, db)
    return await get_seance_by_id(seance_id, db, user_email)

async def delete_seance(seance_id: int, db: Session, user_email: str):
    await get_seance_by_id(seance_id, db, user_email)
    
    delete_req = schemas.GenericDeleteRequest(
        table_name="seance",
        conditions={"id_seance": seance_id}
    )
    await query.execute_generic_delete(delete_req, db)
    return {"message": "Séance supprimée avec succès"}

