from fastapi import HTTPException
from sqlalchemy.orm import Session
from api import schemas
from api.services import query

async def get_all_exercices(db: Session):
    req = schemas.GenericQueryRequest(
        table_name="exercice",
        columns=["id_exercice", "nom"]
    )
    exercices = await query.execute_generic_query(req, db)
    return exercices

async def get_exercice_by_id(exercice_id: int, db: Session):
    req = schemas.GenericQueryRequest(
        table_name="exercice",
        columns=["id_exercice", "nom"],
        conditions={"id_exercice": exercice_id}
    )
    exercices_found = await query.execute_generic_query(req, db)
    if not exercices_found:
        raise HTTPException(status_code=404, detail="Exercice non trouvé")
    return exercices_found[0]

async def create_exercice(exercice: schemas.ExerciceCreate, db: Session):
    try:
        check_req = schemas.GenericQueryRequest(
            table_name="exercice",
            columns=["id_exercice"],
            conditions={"nom": exercice.nom}
        )
        existing = await query.execute_generic_query(check_req, db)
        if existing:
            raise HTTPException(status_code=400, detail="Un exercice avec ce nom existe déjà")
    except Exception as e:
        if isinstance(e, HTTPException):
            raise e
        pass

    create_req = schemas.GenericCreateRequest(
        table_name="exercice",
        data={"nom": exercice.nom}
    )
    
    result = await query.execute_generic_create(create_req, db)
    if result:
        return result[0]
    raise HTTPException(status_code=500, detail="Failed to create exercice")

async def update_exercice(exercice_id: int, exercice_update: schemas.ExerciceUpdate, db: Session):
    # check if exists
    await get_exercice_by_id(exercice_id, db)
    
    updates = {k: v for k, v in exercice_update.model_dump().items() if v is not None}
    if not updates:
        return await get_exercice_by_id(exercice_id, db)
        
    update_req = schemas.GenericUpdateRequest(
        table_name="exercice",
        updates=updates,
        conditions={"id_exercice": exercice_id}
    )
    await query.execute_generic_update(update_req, db)
    
    return await get_exercice_by_id(exercice_id, db)

async def delete_exercice(exercice_id: int, db: Session):
    # Verify it exists
    await get_exercice_by_id(exercice_id, db)
    
    delete_req = schemas.GenericDeleteRequest(
        table_name="exercice",
        conditions={"id_exercice": exercice_id}
    )
    await query.execute_generic_delete(delete_req, db)
    return {"message": "Exercice supprimé avec succès"}

