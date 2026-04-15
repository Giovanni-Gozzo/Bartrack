from fastapi import HTTPException
from sqlalchemy.orm import Session
from api import schemas
from api.services import query

async def get_all_exercices(db: Session):
    """
    Récupère la liste de tous les exercices disponibles dans l'application.
    
    Args:
        db (Session): Session de la base de données.
    
    Returns:
        List[dict]: Liste des exercices trouvés.
    """
    req = schemas.GenericQueryRequest(
        table_name="exercice",
        columns=["id_exercice", "nom"]
    )
    exercices = await query.execute_generic_query(req, db)
    return exercices

async def get_exercice_by_id(exercice_id: int, db: Session):
    """
    Récupère un exercice spécifique à partir de son identifiant.
    
    Args:
        exercice_id (int): L'identifiant de l'exercice à rechercher.
        db (Session): Session de la base de données.
    
    Returns:
        dict: Les données de l'exercice.
        
    Raises:
        HTTPException: Si l'exercice n'est pas trouvé (404).
    """
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
    """
    Crée un nouvel exercice dans le système de référence de l'application.
    
    Vérifie au préalable si l'exercice n'existe pas déjà par son nom.
    
    Args:
        exercice (schemas.ExerciceCreate): Les données de création de l'exercice.
        db (Session): Session de la base de données.
    
    Returns:
        dict: L'exercice nouvellement créé (nom et id).
        
    Raises:
        HTTPException: Si un exercice avec ce nom existe déjà.
    """
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
    """
    Met à jour un exercice existant (ex: changement de nom).
    
    Vérifie d'abord que l'exercice avec l'identifiant renseigné existe.
    
    Args:
        exercice_id (int): Identifiant de l'exercice.
        exercice_update (schemas.ExerciceUpdate): Nouvelles données.
        db (Session): Session de la base de données.
    
    Returns:
        dict: L'exercice mis à jour.
    """
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
    """
    Supprime un exercice de la base de données.
    
    Args:
        exercice_id (int): Identifiant de l'exercice à supprimer.
        db (Session): Session de la base de données.
    
    Returns:
        dict: Message de confirmation de suppression.
    """
    # Verify it exists
    await get_exercice_by_id(exercice_id, db)
    
    delete_req = schemas.GenericDeleteRequest(
        table_name="exercice",
        conditions={"id_exercice": exercice_id}
    )
    await query.execute_generic_delete(delete_req, db)
    return {"message": "Exercice supprimé avec succès"}

