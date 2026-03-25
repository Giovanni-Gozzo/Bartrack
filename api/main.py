import uvicorn
from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session
from api.database import get_db
from api import schemas, auth
from api.services import calculations, query, users, exercices, seances, seance_exos, profil_vbt
from fastapi.middleware.cors import CORSMiddleware
from fastapi.security import OAuth2PasswordRequestForm

app = FastAPI()

origins = [
    "http://localhost:5173"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
async def hello():
    return {"message": "Hello World"}

@app.post(
    "/initialize",
    tags=["Calculations"],
    summary="Initialize the system with given parameters",
    description=(
        "Calcule le slope et l'intercept à partir des deux paires (RPE, vitesse). "
        "La formule est: slope = (rpe_high - rpe_low) / (speed_high - speed_low). "
        "Intercept = rpe_high - slope * speed_high."
    ),
)
async def initialize(payload: schemas.InitRequest, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await calculations.initialize_profile(payload, db, current_user)

@app.post(
    "/compute_rpe",
    tags=["Calculations"],
    summary="Compute RPE from speed, slope and intercept",
    description="Calcule le RPE selon la formule rpe = slope * speed + intercept",
)
async def compute_rpe(payload: schemas.ComputeRpeRequest, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await calculations.calculate_rpe(payload, db, current_user)

@app.post(
    "/compute_weight",
    tags=["Calculations"],
    summary="Compute weight from 1RM and RPE")
async def compute_weight(payload: schemas.PoidsRPE, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await calculations.calculate_weight(payload, db, current_user)

@app.post("/generic_query", tags=["Database Queries"], summary="Generic database query")
async def generic_query(request: schemas.GenericQueryRequest, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    """
    Executes a SELECT query on the specified table.
    """
    return await query.execute_generic_query(request, db)

@app.post("/generic_update", tags=["Database Queries"], summary="Generic database update")
async def generic_update(request: schemas.GenericUpdateRequest, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    """
    Executes an UPDATE query on the specified table.
    """
    return await query.execute_generic_update(request, db)

@app.post("/generic_create", tags=["Database Queries"], summary="Generic database create")
async def generic_create(request: schemas.GenericCreateRequest, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    """
    Executes an INSERT query on the specified table.
    """
    return await query.execute_generic_create(request, db)

@app.post("/users/", tags=["Utilisateurs"])
async def register_user(user: schemas.UserCreate, db: Session = Depends(get_db)):
    return await users.register_new_user(user, db)

@app.get("/users/me", tags=["Utilisateurs"], summary="Get current user profile")
async def get_profile(db: Session = Depends(get_db), current_user_email: str = Depends(auth.get_current_user)):
    return await users.get_current_user_profile(current_user_email, db)

@app.put("/users/me", tags=["Utilisateurs"], summary="Update current user profile")
async def update_profile(user_update: schemas.UserUpdate, db: Session = Depends(get_db), current_user_email: str = Depends(auth.get_current_user)):
    return await users.update_user_profile(user_update, db, current_user_email)

@app.post("/rm1_users/", tags=["Calculations"])
async def rm1_users(users_req: schemas.Rm1Users, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await users.rm1_users(users_req, db, current_user)

@app.post("/daily_1rm/", tags=["Calculations"])
async def daily_1rm(users_req: schemas.Daily1rmRequest, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await calculations.calculate_daily_1rm(users_req, db, current_user)

@app.post("/login", tags=["Authentification"], summary="Login user")
async def login(form_data: OAuth2PasswordRequestForm = Depends(), db: Session = Depends(get_db)):
    """
    Compatible avec le bouton 'Authorize' du Swagger UI.
    Utilise 'username' pour l'email.
    """
    # Map form "username" to our "email" field
    login_req = schemas.LoginRequest(
        email=form_data.username,
        mot_de_passe=form_data.password
    )
    return await users.authenticate_user(login_req, db)

@app.get("/exercices/", tags=["Exercices"], summary="Get all exercices")
async def get_all_exercices(db: Session = Depends(get_db)):
    return await exercices.get_all_exercices(db)

@app.get("/exercices/{exercice_id}", tags=["Exercices"], summary="Get an exercice by ID")
async def get_exercice(exercice_id: int, db: Session = Depends(get_db)):
    return await exercices.get_exercice_by_id(exercice_id, db)

@app.post("/exercices/", tags=["Exercices"], summary="Create a new exercice")
async def create_exercice(exercice: schemas.ExerciceCreate, db: Session = Depends(get_db), admin_email: str = Depends(auth.require_admin)):
    return await exercices.create_exercice(exercice, db)

@app.put("/exercices/{exercice_id}", tags=["Exercices"], summary="Update an exercice")
async def update_exercice(exercice_id: int, exercice_update: schemas.ExerciceUpdate, db: Session = Depends(get_db), admin_email: str = Depends(auth.require_admin)):
    return await exercices.update_exercice(exercice_id, exercice_update, db)

@app.delete("/exercices/{exercice_id}", tags=["Exercices"], summary="Delete an exercice")
async def delete_exercice(exercice_id: int, db: Session = Depends(get_db), admin_email: str = Depends(auth.require_admin)):
    return await exercices.delete_exercice(exercice_id, db)

@app.get("/seances/", tags=["Séances"], summary="Get all seances for current user")
async def get_all_seances(db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await seances.get_all_seances(db, current_user)

@app.get("/seances/{seance_id}", tags=["Séances"], summary="Get a seance by ID")
async def get_seance(seance_id: int, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await seances.get_seance_by_id(seance_id, db, current_user)

@app.post("/seances/", tags=["Séances"], summary="Create a new seance")
async def create_seance(seance: schemas.SeanceCreate, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await seances.create_seance(seance, db, current_user)

@app.put("/seances/{seance_id}", tags=["Séances"], summary="Update a seance")
async def update_seance(seance_id: int, seance_update: schemas.SeanceUpdate, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await seances.update_seance(seance_id, seance_update, db, current_user)

@app.delete("/seances/{seance_id}", tags=["Séances"], summary="Delete a seance")
async def delete_seance(seance_id: int, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await seances.delete_seance(seance_id, db, current_user)

@app.get("/seances/{seance_id}/exos", tags=["Séances Exos"], summary="Get all exercices for a seance")
async def get_seance_exos(seance_id: int, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await seance_exos.get_all_seance_exos_for_seance(seance_id, db, current_user)

@app.get("/seance_exos/{id_seance_exo}", tags=["Séances Exos"], summary="Get a seance_exo by ID")
async def get_seance_exo(id_seance_exo: int, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await seance_exos.get_seance_exo_by_id(id_seance_exo, db, current_user)

@app.post("/seance_exos/", tags=["Séances Exos"], summary="Add an exercice to a seance")
async def create_seance_exo(seance_exo: schemas.SeanceExoCreate, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await seance_exos.create_seance_exo(seance_exo, db, current_user)

@app.put("/seance_exos/{id_seance_exo}", tags=["Séances Exos"], summary="Update a seance_exo")
async def update_seance_exo(id_seance_exo: int, update_data: schemas.SeanceExoUpdate, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await seance_exos.update_seance_exo(id_seance_exo, update_data, db, current_user)

@app.delete("/seance_exos/{id_seance_exo}", tags=["Séances Exos"], summary="Delete a seance_exo")
async def delete_seance_exo(id_seance_exo: int, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await seance_exos.delete_seance_exo(id_seance_exo, db, current_user)

@app.get("/profil_vbt/", tags=["Profil VBT"], summary="Get all Profil VBT for current user")
async def get_all_profils_vbt(db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await profil_vbt.get_all_profils_vbt(db, current_user)

@app.get("/profil_vbt/{id_exercice}", tags=["Profil VBT"], summary="Get Profil VBT by exercice ID")
async def get_profil_vbt(id_exercice: int, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await profil_vbt.get_profil_vbt_by_exercice(id_exercice, db, current_user)

@app.post("/profil_vbt/", tags=["Profil VBT"], summary="Create a Profil VBT")
async def create_profil_vbt(profil: schemas.ProfilVbtCreate, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await profil_vbt.create_profil_vbt(profil, db, current_user)

@app.put("/profil_vbt/{id_exercice}", tags=["Profil VBT"], summary="Update Profil VBT for an exercice")
async def update_profil_vbt(id_exercice: int, update_data: schemas.ProfilVbtUpdate, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await profil_vbt.update_profil_vbt(id_exercice, update_data, db, current_user)

@app.delete("/profil_vbt/{id_exercice}", tags=["Profil VBT"], summary="Delete Profil VBT for an exercice")
async def delete_profil_vbt(id_exercice: int, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await profil_vbt.delete_profil_vbt(id_exercice, db, current_user)

if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8001)
