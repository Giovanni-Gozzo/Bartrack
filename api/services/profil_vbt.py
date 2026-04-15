from fastapi import HTTPException
from sqlalchemy.orm import Session
from api import schemas
from api.services import query, users
from datetime import datetime

async def get_all_profils_vbt(db: Session, user_email: str):
    """
    Récupère tous les profils VBT (Velocity Based Training) pour l'utilisateur courant.
    
    Args:
        db (Session): Session de la base de données.
        user_email (str): L'email de l'utilisateur courant.
        
    Returns:
        List[dict]: Liste des profils.
    """
    user = await users.get_user_by_email(user_email, db)
    user_id = int(user["id_utilisateur"])
    
    req = schemas.GenericQueryRequest(
        table_name="profil_vbt",
        columns=["id_utilisateur", "id_exercice", "current_1rm", "slope", "intercept", "last_updated"],
        conditions={"id_utilisateur": user_id}
    )
    return await query.execute_generic_query(req, db)

async def get_profil_vbt_by_exercice(id_exercice: int, db: Session, user_email: str):
    """
    Récupère le profil VBT d'un utilisateur pour un exercice spécifique.
    
    Args:
        id_exercice (int): Identifiant de l'exercice (ex: squat, développé couché).
        db (Session): Session de la base de données.
        user_email (str): Email de l'utilisateur.
        
    Returns:
        dict: Les détails du profil VBT (pente, ordonnée à l'origine, rmax).
        
    Raises:
        HTTPException: Si aucun profil n'est trouvé.
    """
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
    """
    Crée un nouveau profil VBT pour l'utilisateur actif sur un exercice donné.
    
    Vérifie qu'aucun profil n'existe déjà pour cette paire utilisateur/exercice.
    
    Args:
        profil_vbt (schemas.ProfilVbtCreate): Paramètres initiaux du profil.
        db (Session): Session de la base de données.
        user_email (str): L'email de l'utilisateur actif.
        
    Returns:
        dict: Un message de confirmation avec l'ID de l'exercice.
    """
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
    """
    Met à jour un profil VBT existant.
    
    Args:
        id_exercice (int): L'identifiant de l'exercice affecté.
        profil_vbt_update (schemas.ProfilVbtUpdate): Les champs à mettre à jour.
        db (Session): Session de la base de données.
        user_email (str): L'email de l'utilisateur actif.
        
    Returns:
        dict: Le profil mis à jour depuis la base de données.
    """
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
    """
    Supprime le profil VBT lié à un exercice pour l'utilisateur courant.
    
    Args:
        id_exercice (int): Identifiant de l'exercice dont on supprime le profil.
        db (Session): Session de base de données.
        user_email (str): L'email de l'utilisateur.
        
    Returns:
        dict: Message texte confirmant la suppression.
    """
    user = await users.get_user_by_email(user_email, db)
    user_id = int(user["id_utilisateur"])
    
    await get_profil_vbt_by_exercice(id_exercice, db, user_email)
    
    delete_req = schemas.GenericDeleteRequest(
        table_name="profil_vbt",
        conditions={"id_utilisateur": user_id, "id_exercice": id_exercice}
    )
    await query.execute_generic_delete(delete_req, db)
    return {"message": "Profil VBT supprimé avec succès"}
