from fastapi import HTTPException
from sqlalchemy.orm import Session
from api import schemas
from api.services import query, users

# --- Programmes ---

async def create_programme(payload: schemas.ProgrammeCreate, db: Session, user_email: str):
    """
    Crée un programme d'entraînement vide pour un utilisateur.
    
    Args:
        payload (schemas.ProgrammeCreate): Les informations de base du programme (nom, description).
        db (Session): Session de base de données.
        user_email (str): L'email de l'utilisateur concerné.
    Returns:
        dict: Le programme nouvellement créé avec son identifiant.
    """
    user = await users.get_user_by_email(user_email, db)
    user_id = int(user["id_utilisateur"])
    
    data = payload.model_dump()
    data["id_utilisateur"] = user_id
    
    req = schemas.GenericCreateRequest(table_name="programme", data=data)
    result = await query.execute_generic_create(req, db)
    return result[0]

async def get_my_programmes(db: Session, user_email: str):
    """
    Récupère la liste de tous les programmes d'entraînement de l'utilisateur actif.
    
    Args:
        db (Session): Session de la base de données.
        user_email (str): L'email de l'utilisateur.
    Returns:
        List[dict]: La liste des programmes.
    """
    user = await users.get_user_by_email(user_email, db)
    user_id = int(user["id_utilisateur"])
    
    req = schemas.GenericQueryRequest(
        table_name="programme",
        conditions={"id_utilisateur": user_id}
    )
    return await query.execute_generic_query(req, db)

async def get_programme(programme_id: int, db: Session, user_email: str):
    """
    Récupère les informations d'un programme d'entraînement par son identifiant.
    
    Vérifie qu'il appartient bien à l'utilisateur demandeur.
    
    Args:
        programme_id (int): L'identifiant du programme.
        db (Session): Session de la base de données.
        user_email (str): L'email de l'utilisateur.
    Returns:
        dict: Le programme.
    """
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
    """
    Met à jour les informations d'un programme (ex: nom, description).
    
    Args:
        programme_id (int): L'identifiant du programme.
        payload (schemas.ProgrammeUpdate): Nouvelles informations.
        db (Session): Session db.
        user_email (str): L'email de l'utilisateur owner.
    Returns:
        dict: Le message de succès d'update.
    """
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
    """
    Supprime un programme d'entraînement et virtuellement ses dépendances s'il y a CASCADE.
    
    Args:
        programme_id (int): L'identifiant du programme à supprimer.
        db (Session): Session de base de données.
        user_email (str): L'email de l'utilisateur.
    Returns:
        dict: Le statut ou result.rowcount de la suppression.
    """
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
    result = await query.execute_generic_create(req, db)
    return result[0]

async def get_programme_exercices(programme_id: int, db: Session, user_email: str):
    """
    Récupère les exercices d'un programme, triés par ordre de passage.

    Les colonnes sont spécifiées explicitement pour éviter tout conflit de cache
    de métadonnées SQLAlchemy avec d'autres tables (ex: 'echauffement'
    appartient à 'serie', pas à 'programme_exercice').

    Args:
        programme_id (int): L'identifiant du programme.
        db (Session): Session de base de données.
        user_email (str): L'email de l'utilisateur.
    Returns:
        List[dict]: Les exercices triés par ordre_passage.
    """
    # Verify programme ownership
    await get_programme(programme_id, db, user_email)

    req = schemas.GenericQueryRequest(
        table_name="programme_exercice",
        columns=["id", "id_programme", "id_exercice", "ordre_passage",
                 "nombre_series", "nombre_reps", "charge_prevue", "rpe_cible"],
        conditions={"id_programme": programme_id}
    )
    data = await query.execute_generic_query(req, db)
    return sorted(data, key=lambda x: x["ordre_passage"])

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

async def create_full_programme(payload: schemas.ProgrammeFullCreate, db: Session, user_email: str):
    # 1. Create the programme
    prog_payload = schemas.ProgrammeCreate(
        nom_programme=payload.nom_programme,
        description=payload.description
    )
    programme = await create_programme(prog_payload, db, user_email)
    programme_id = programme["id"]
    
    # 2. Create each exercise
    created_exercises = []
    for exo_data in payload.exercices:
        pe_payload = schemas.ProgrammeExerciceCreate(
            id_programme=programme_id,
            id_exercice=exo_data.id_exercice,
            ordre_passage=exo_data.ordre_passage,
            nombre_series=exo_data.nombre_series,
            nombre_reps=exo_data.nombre_reps,
            charge_prevue=exo_data.charge_prevue,
            rpe_cible=exo_data.rpe_cible,
            echauffement=exo_data.echauffement
        )
        # We call the existing service to reuse logic (ownership check etc.)
        exo = await create_programme_exercice(pe_payload, db, user_email)
        created_exercises.append(exo)
        
    # 3. Return full structure
    return {
        **programme,
        "exercices": created_exercises
    }

async def get_full_programme(programme_id: int, db: Session, user_email: str):
    programme = await get_programme(programme_id, db, user_email)
    
    # 2. Get exercises
    exercises = await get_programme_exercices(programme_id, db, user_email)
    
    return {
        **programme,
        "exercices": exercises
    }

async def update_full_programme(programme_id: int, payload: schemas.ProgrammeFullUpdate, db: Session, user_email: str):
    # 1. Update programme metadata if provided
    if payload.nom_programme is not None or payload.description is not None:
        prog_update = schemas.ProgrammeUpdate(
            nom_programme=payload.nom_programme,
            description=payload.description
        )
        await update_programme(programme_id, payload=prog_update, db=db, user_email=user_email)
    
    # 2. Update exercises if provided
    if payload.exercices is not None:
        # Simplest approach for "Full Update": Delete existing and recreate
        # This ensures the list matches exactly the input (order, content)
        
        # Get current exercises to delete them one by one (to trigger any business logic if needed)
        # or use a generic delete if we had one for multiple rows.
        current_exos = await get_programme_exercices(programme_id, db, user_email)
        for exo in current_exos:
            await delete_programme_exercice(exo["id"], db, user_email)
            
        # Create new ones
        for exo_data in payload.exercices:
            pe_payload = schemas.ProgrammeExerciceCreate(
                id_programme=programme_id,
                id_exercice=exo_data.id_exercice,
                ordre_passage=exo_data.ordre_passage,
                nombre_series=exo_data.nombre_series,
                nombre_reps=exo_data.nombre_reps,
                charge_prevue=exo_data.charge_prevue,
                rpe_cible=exo_data.rpe_cible,
                echauffement=exo_data.echauffement
            )
            await create_programme_exercice(pe_payload, db, user_email)
            
    # 3. Return the updated full programme
    return await get_full_programme(programme_id, db, user_email)

async def get_my_full_programmes(db: Session, user_email: str):
    # 1. Get all basic programmes
    programmes = await get_my_programmes(db, user_email)


    # 2. Enrich each with its exercises
    full_programmes = []
    for prog in programmes:
        exos = await get_programme_exercices(prog["id"], db, user_email)
        full_programmes.append({
            **prog,
            "exercices": exos
        })
        
    return full_programmes
