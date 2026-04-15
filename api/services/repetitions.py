from fastapi import HTTPException
from sqlalchemy.orm import Session
from api import schemas
from api.services import query, series

async def get_all_repetitions_for_serie(id_serie: int, db: Session, user_email: str):
    """
    Récupère toutes les répétitions appartenant à une série spécifique.
    
    Args:
        id_serie (int): L'identifiant de la série paretrnt.
        db (Session): Session de base de données.
        user_email (str): Email de l'utilisateur actif.
    
    Returns:
        List[dict]: La liste des répétitions associées à la série.
    """
    await series.get_serie_by_id(id_serie, db, user_email)
    
    req = schemas.GenericQueryRequest(
        table_name="repetition",
        columns=["id", "id_serie", "numero_rep", "vitesse_mesuree"],
        conditions={"id_serie": id_serie}
    )
    return await query.execute_generic_query(req, db)

async def get_repetition_by_id(id_repetition: int, db: Session, user_email: str):
    """
    Récupère une répétition spécifique par son identifiant.
    
    Vérifie également que la série associée appartient bien à l'utilisateur courant.
    
    Args:
        id_repetition (int): ID de la répétition.
        db (Session): Session Db.
        user_email (str): Email de l'utilisateur concerné.
        
    Returns:
        dict: Les détails de la répétition.
    """
    req = schemas.GenericQueryRequest(
        table_name="repetition",
        columns=["id", "id_serie", "numero_rep", "vitesse_mesuree"],
        conditions={"id": id_repetition}
    )
    results = await query.execute_generic_query(req, db)
    if not results:
        raise HTTPException(status_code=404, detail="Répétition non trouvée")
    repetition = results[0]
    
    await series.get_serie_by_id(repetition["id_serie"], db, user_email)
    
    return repetition

async def create_repetition(repetition: schemas.RepetitionCreate, db: Session, user_email: str):
    """
    Ajoute une nouvelle répétition à une série en précisant ex: la vitesse mesurée.
    
    Args:
        repetition (schemas.RepetitionCreate): Les informations de la nouvelle rep.
        db (Session): Session db.
        user_email (str): Utilisateur actuel.
    """
    await series.get_serie_by_id(repetition.id_serie, db, user_email)
    
    create_req = schemas.GenericCreateRequest(
        table_name="repetition",
        data={
            "id_serie": repetition.id_serie,
            "numero_rep": repetition.numero_rep,
            "vitesse_mesuree": repetition.vitesse_mesuree
        }
    )
    result = await query.execute_generic_create(create_req, db)
    if result:
        return result[0]
    raise HTTPException(status_code=500, detail="Échec de la création de la répétition")

async def update_repetition(id_repetition: int, repetition_update: schemas.RepetitionUpdate, db: Session, user_email: str):
    """
    Met à jour les détails d'une répétition (ex: la vitesse, son numéro).
    
    Args:
        id_repetition (int): L'ID de la répétition.
        repetition_update (schemas.RepetitionUpdate): Object contenant les modifications.
        db (Session): Session Db.
        user_email (str): L'utilisateur associé.
    """
    await get_repetition_by_id(id_repetition, db, user_email)
    
    updates = repetition_update.model_dump(exclude_unset=True)
    if not updates:
        return await get_repetition_by_id(id_repetition, db, user_email)
        
    update_req = schemas.GenericUpdateRequest(
        table_name="repetition",
        updates=updates,
        conditions={"id": id_repetition}
    )
    await query.execute_generic_update(update_req, db)
    return await get_repetition_by_id(id_repetition, db, user_email)

async def delete_repetition(id_repetition: int, db: Session, user_email: str):
    """
    Supprime une répétition de la série.
    
    Args:
        id_repetition (int): L'identifiant de la répétition à supprimer.
        db (Session): Session db.
        user_email (str): L'email de l'utilisateur.
    """
    await get_repetition_by_id(id_repetition, db, user_email)
    
    delete_req = schemas.GenericDeleteRequest(
        table_name="repetition",
        conditions={"id": id_repetition}
    )
    await query.execute_generic_delete(delete_req, db)
    return {"message": "Répétition supprimée avec succès"}
