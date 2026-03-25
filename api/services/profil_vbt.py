from fastapi import HTTPException
from sqlalchemy.orm import Session
from api import schemas
from api.services import query, users
from datetime import datetime

async def get_all_profils_vbt(db: Session, user_email: str):
    user = await users.get_user_by_email(user_email, db)
    user_id = int(user["id_utilisateur"])
    
    req = schemas.GenericQueryRequest(
        table_name="profil_vbt",
        columns=["id_utilisateur", "id_exercice", "current_1rm", "slope", "intercept", "last_updated"],
        conditions={"id_utilisateur": user_id}
    )
    return await query.execute_generic_query(req, db)

async def get_profil_vbt_by_exercice(id_exercice: int, db: Session, user_email: str):
    user = await users.get_user_by_email(user_email, db)
    user_id = int(user["id_utilisateur"])
    
    req = schemas.GenericQueryRequest(
        table_name="profil_vbt",
        columns=["id_utilisateur", "id_exercice", "current_1rm", "slope", "intercept", "last_updated"],
        conditions={"id_utilisateur": user_id, "id_exercice": id_exercice}
    )
    results = await query.execute_generic_query(req, db)
    if not results:
        raise HTTPException(status_code=404, detail="Profil VBT non trouvé pour cet exercice")
    return results[0]

async def create_profil_vbt(profil_vbt: schemas.ProfilVbtCreate, db: Session, user_email: str):
    user = await users.get_user_by_email(user_email, db)
    user_id = int(user["id_utilisateur"])
    
    # Check if already exists
    req = schemas.GenericQueryRequest(
        table_name="profil_vbt",
        columns=["id_utilisateur"],
        conditions={"id_utilisateur": user_id, "id_exercice": profil_vbt.id_exercice}
    )
    existing = await query.execute_generic_query(req, db)
    if existing:
        raise HTTPException(status_code=400, detail="Profil VBT déjà existant pour cet exercice, veuillez faire une mise à jour.")
        
    create_req = schemas.GenericCreateRequest(
        table_name="profil_vbt",
        data={
            "id_utilisateur": user_id,
            "id_exercice": profil_vbt.id_exercice,
            "current_1rm": profil_vbt.current_1rm,
            "slope": profil_vbt.slope,
            "intercept": profil_vbt.intercept,
            "last_updated": datetime.now().isoformat()
        }
    )
    result = await query.execute_generic_create(create_req, db)
    if result:
        return {"message": "Profil VBT créé avec succès", "id_exercice": profil_vbt.id_exercice}
    raise HTTPException(status_code=500, detail="Échec de la création du profil VBT")

async def update_profil_vbt(id_exercice: int, profil_vbt_update: schemas.ProfilVbtUpdate, db: Session, user_email: str):
    user = await users.get_user_by_email(user_email, db)
    user_id = int(user["id_utilisateur"])
    
    await get_profil_vbt_by_exercice(id_exercice, db, user_email)
    
    updates = profil_vbt_update.model_dump(exclude_unset=True)
    if not updates:
        return await get_profil_vbt_by_exercice(id_exercice, db, user_email)
    
    updates["last_updated"] = datetime.now().isoformat()
        
    update_req = schemas.GenericUpdateRequest(
        table_name="profil_vbt",
        updates=updates,
        conditions={"id_utilisateur": user_id, "id_exercice": id_exercice}
    )
    await query.execute_generic_update(update_req, db)
    return await get_profil_vbt_by_exercice(id_exercice, db, user_email)

async def delete_profil_vbt(id_exercice: int, db: Session, user_email: str):
    user = await users.get_user_by_email(user_email, db)
    user_id = int(user["id_utilisateur"])
    
    await get_profil_vbt_by_exercice(id_exercice, db, user_email)
    
    delete_req = schemas.GenericDeleteRequest(
        table_name="profil_vbt",
        conditions={"id_utilisateur": user_id, "id_exercice": id_exercice}
    )
    await query.execute_generic_delete(delete_req, db)
    return {"message": "Profil VBT supprimé avec succès"}
