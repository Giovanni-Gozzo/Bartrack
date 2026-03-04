from datetime import timedelta
from fastapi import HTTPException
from sqlalchemy.orm import Session
from api import schemas, auth
from api.services import query

async def register_new_user(user: schemas.UserCreate, db: Session):
    try:
        check_req = schemas.GenericQueryRequest(
            table_name="utilisateur",
            columns=["id_utilisateur"],
            conditions={"email": user.email}
        )
        existing_user = await query.execute_generic_query(check_req, db)
        if existing_user:
            raise HTTPException(status_code=400, detail="Email déjà enregistré")
    except Exception:
        pass

    hashed_pwd = auth.hash_password(user.mot_de_passe)

    user_data = user.model_dump()
    user_data["mot_de_passe"] = hashed_pwd

    create_req = schemas.GenericCreateRequest(
        table_name="utilisateur",
        data=user_data
    )
    
    result = await query.execute_generic_create(create_req, db)
    
    if result:
        return {"message": "coucou c'est créé"}
    raise HTTPException(status_code=500, detail="Failed to create user")

async def get_user_by_email(email: str, db: Session):
    req = schemas.GenericQueryRequest(
        table_name="utilisateur",
        columns=["id_utilisateur", "email"],
        conditions={"email": email}
    )
    users_found = await query.execute_generic_query(req, db)
    if not users_found:
        raise HTTPException(status_code=404, detail="Utilisateur non trouvé")
    return users_found[0]

async def rm1_users(users:schemas.Rm1Users, db: Session, user_email: str):
    try:
        # Get user ID
        current_user = await get_user_by_email(user_email, db)
        user_id = int(current_user["id_utilisateur"])
        
        req = schemas.GenericQueryRequest(
            table_name="profil_vbt",
            columns=["*"],
            conditions={"id_utilisateur": user_id, "id_exercice": int(users.id_exercice)}
        )
        existing_user = await query.execute_generic_query(req, db)
        
        if existing_user:
            update_req = schemas.GenericUpdateRequest(
                table_name="profil_vbt",
                updates={"current_1rm": users.current_1rm},
                conditions={"id_utilisateur": user_id, "id_exercice": int(users.id_exercice)}
            )
            await query.execute_generic_update(update_req, db)
            return existing_user[0]
        else:
            create_req = schemas.GenericCreateRequest(
                table_name="profil_vbt",
                data={"id_utilisateur": user_id, "id_exercice": int(users.id_exercice), "current_1rm": users.current_1rm}
            )
            result = await query.execute_generic_create(create_req, db)
            if result:
                return result[0]
            raise HTTPException(status_code=500, detail="Failed to create user")
                
    except Exception as e:
        print(f"Error in rm1_users: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Failed to update user: {str(e)}")

async def authenticate_user(login_data: schemas.LoginRequest, db: Session):
    try:
        # Fetch user by email
        req = schemas.GenericQueryRequest(
            table_name="utilisateur",
            # We need password to verify, and other info to return
            columns=["id_utilisateur", "mot_de_passe", "nom", "prenom", "email"],
            conditions={"email": login_data.email}
        )
        users_found = await query.execute_generic_query(req, db)
        
        if not users_found:
            raise HTTPException(status_code=401, detail="Email ou mot de passe incorrect")
        
        user = users_found[0]
        
        # Verify password
        if not auth.verify_password(login_data.mot_de_passe, user["mot_de_passe"]):
            raise HTTPException(status_code=401, detail="Email ou mot de passe incorrect")
        
        # Remove password from response
        user.pop("mot_de_passe")
        
        # Generate token
        access_token_expires = timedelta(minutes=auth.ACCESS_TOKEN_EXPIRE_MINUTES)
        access_token = auth.create_access_token(
            data={"sub": user["email"]}, expires_delta=access_token_expires
        )
        
        return {
            "access_token": access_token, 
            "token_type": "bearer",
            "user": user
        }
        
    except HTTPException as he:
        raise he
    except Exception as e:
        print(f"Error in login: {e}")
        raise HTTPException(status_code=500, detail="Login failed")