from fastapi import HTTPException
from sqlalchemy.orm import Session
from api import schemas
from api.services import query, seances

async def get_all_seance_exos_for_seance(seance_id: int, db: Session, user_email: str):
    """
    Récupère tous les exercices associés à une séance.
    
    Args:
        seance_id (int): L'ID de la séance.
        db (Session): La session de la base de données.
        user_email (str): L'email de l'utilisateur effectuant la requête.
    """
    # Verify the seance belongs to the user
    await seances.get_seance_by_id(seance_id, db, user_email)
    
    req = schemas.GenericQueryRequest(
        table_name="seance_exo",
        columns=["id_seance_exo", "id_seance", "id_exercice", "daily_1rm"],
        conditions={"id_seance": seance_id}
    )
    return await query.execute_generic_query(req, db)

async def get_seance_exo_by_id(id_seance_exo: int, db: Session, user_email: str):
    """
    Récupère un exercice de séance spécifique.
    
    Utile pour voir le daily_1rm associé ou avant de modifier.
    
    Args:
        id_seance_exo (int): L'identifiant du lien séance / exercice.
        db (Session): Session DB.
        user_email (str): Email de l'utilisateur en cours.
    """
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
    """
    Ajoute un nouvel exercice dans une séance d'entraînement.
    
    Args:
        seance_exo (schemas.SeanceExoCreate): L'ID séance, ID exercice, daily_1rm possible.
        db (Session): La base de données.
        user_email (str): Email de l'utilisateur actif.
    """
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
    """
    Met à jour un exercice de séance (ex: mise à jour du daily_1rm en fin de séance).
    
    Args:
        id_seance_exo (int): Identifiant unique de the la liaison.
        seance_exo_update (schemas.SeanceExoUpdate): Nouvelle donnée.
        db (Session): Base de données.
        user_email (str): L'utilisateur en instance.
    """
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
    """
    Supprime un exercice d'une séance.
    
    Args:
        id_seance_exo (int): ID du lien a effacer.
        db (Session): Session db.
        user_email (str): L'utilisateur affecté.
    """
    await get_seance_exo_by_id(id_seance_exo, db, user_email)
    
    delete_req = schemas.GenericDeleteRequest(
        table_name="seance_exo",
        conditions={"id_seance_exo": id_seance_exo}
    )
    await query.execute_generic_delete(delete_req, db)
    return {"message": "Seance_exo supprimé avec succès"}
