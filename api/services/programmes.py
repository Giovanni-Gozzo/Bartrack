from fastapi import HTTPException
from sqlalchemy.orm import Session
from api import schemas
from api.services import query, users

# --- Programmes ---

async def create_programme(payload: schemas.ProgrammeCreate, db: Session, user_email: str):
    user = await users.get_user_by_email(user_email, db)
    user_id = int(user["id_utilisateur"])
    
    data = payload.model_dump()
    data["id_utilisateur"] = user_id
    
    req = schemas.GenericCreateRequest(table_name="programme", data=data)
    result = await query.execute_generic_create(req, db)
    return result

async def get_my_programmes(db: Session, user_email: str):
    user = await users.get_user_by_email(user_email, db)
    user_id = int(user["id_utilisateur"])
    
    req = schemas.GenericQueryRequest(
        table_name="programme",
        conditions={"id_utilisateur": user_id}
    )
    return await query.execute_generic_query(req, db)

async def get_programme(programme_id: int, db: Session, user_email: str):
    user = await users.get_user_by_email(user_email, db)
    user_id = int(user["id_utilisateur"])
    
    req = schemas.GenericQueryRequest(
        table_name="programme",
        conditions={"id": programme_id, "id_utilisateur": user_id}
    )
    data = await query.execute_generic_query(req, db)
    if not data:
        raise HTTPException(status_code=404, detail="Programme non trouvé")
    return data[0]

async def update_programme(programme_id: int, payload: schemas.ProgrammeUpdate, db: Session, user_email: str):
    # Verify ownership
    await get_programme(programme_id, db, user_email)
    
    user = await users.get_user_by_email(user_email, db)
    user_id = int(user["id_utilisateur"])
    
    req = schemas.GenericUpdateRequest(
        table_name="programme",
        updates=payload.model_dump(exclude_unset=True),
        conditions={"id": programme_id, "id_utilisateur": user_id}
    )
    return await query.execute_generic_update(req, db)

async def delete_programme(programme_id: int, db: Session, user_email: str):
    # Verify ownership
    await get_programme(programme_id, db, user_email)
    
    user = await users.get_user_by_email(user_email, db)
    user_id = int(user["id_utilisateur"])
    
    # Optional: Delete associated programme_exercices first if not handled by CASCADE
    # For now, we assume standard behavior or manual management.
    
    req = schemas.GenericDeleteRequest(
        table_name="programme",
        conditions={"id": programme_id, "id_utilisateur": user_id}
    )
    return await query.execute_generic_delete(req, db)

# --- Programme Exercices ---

async def create_programme_exercice(payload: schemas.ProgrammeExerciceCreate, db: Session, user_email: str):
    # Verify programme ownership
    await get_programme(payload.id_programme, db, user_email)
    
    req = schemas.GenericCreateRequest(table_name="programme_exercice", data=payload.model_dump())
    return await query.execute_generic_create(req, db)

async def get_programme_exercices(programme_id: int, db: Session, user_email: str):
    # Verify programme ownership
    await get_programme(programme_id, db, user_email)
    
    # Use explicit columns or generic query
    req = schemas.GenericQueryRequest(
        table_name="programme_exercice",
        conditions={"id_programme": programme_id}
    )
    # Order by ordre_passage can be handled in logic or if we extend generic query
    data = await query.execute_generic_query(req, db)
    # Manual sort if generic query doesn't support ORDER BY
    return sorted(data, key=lambda x: x['ordre_passage'])

async def update_programme_exercice(pe_id: int, payload: schemas.ProgrammeExerciceUpdate, db: Session, user_email: str):
    # Retrieve current to verify ownership of parent programme
    req_get = schemas.GenericQueryRequest(table_name="programme_exercice", conditions={"id": pe_id})
    current = await query.execute_generic_query(req_get, db)
    if not current:
         raise HTTPException(status_code=404, detail="Exercice du programme non trouvé")
    
    await get_programme(current[0]["id_programme"], db, user_email)
    
    req = schemas.GenericUpdateRequest(
        table_name="programme_exercice",
        updates=payload.model_dump(exclude_unset=True),
        conditions={"id": pe_id}
    )
    return await query.execute_generic_update(req, db)

async def delete_programme_exercice(pe_id: int, db: Session, user_email: str):
    # Retrieve current to verify ownership of parent programme
    req_get = schemas.GenericQueryRequest(table_name="programme_exercice", conditions={"id": pe_id})
    current = await query.execute_generic_query(req_get, db)
    if not current:
         raise HTTPException(status_code=404, detail="Exercice du programme non trouvé")
    
    await get_programme(current[0]["id_programme"], db, user_email)
    
    req = schemas.GenericDeleteRequest(
        table_name="programme_exercice",
        conditions={"id": pe_id}
    )
    return await query.execute_generic_delete(req, db)
