import uvicorn
from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session
from api.database import get_db
from api import schemas, auth
from api.services import calculations, query, users, exercices, seances, seance_exos, profil_vbt, series, repetitions, programmes
from fastapi.middleware.cors import CORSMiddleware
from fastapi.security import OAuth2PasswordRequestForm

app = FastAPI()

origins = ["*"]
  
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

@app.post("/rolling_vbt", tags=["Calculations"], summary="30-day Rolling VBT Profile Calculation")
async def compute_rolling_vbt(payload: schemas.RollingCalculationRequest, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await calculations.compute_rolling_vbt_profile(payload, db, current_user)

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

@app.get("/seance_exos/{id_seance_exo}/series", tags=["Séries"], summary="Get all series for a seance_exo")
async def get_series_for_seance_exo(id_seance_exo: int, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await series.get_all_series_for_seance_exo(id_seance_exo, db, current_user)

@app.get("/series/{id_serie}", tags=["Séries"], summary="Get a serie by ID")
async def get_serie(id_serie: int, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await series.get_serie_by_id(id_serie, db, current_user)

@app.post("/series/", tags=["Séries"], summary="Create a serie")
async def create_serie(serie: schemas.SerieCreate, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await series.create_serie(serie, db, current_user)

@app.put("/series/{id_serie}", tags=["Séries"], summary="Update a serie")
async def update_serie(id_serie: int, update_data: schemas.SerieUpdate, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await series.update_serie(id_serie, update_data, db, current_user)

@app.delete("/series/{id_serie}", tags=["Séries"], summary="Delete a serie")
async def delete_serie(id_serie: int, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await series.delete_serie(id_serie, db, current_user)

@app.get("/series/{id_serie}/repetitions", tags=["Répétitions"], summary="Get all repetitions for a serie")
async def get_repetitions_for_serie(id_serie: int, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await repetitions.get_all_repetitions_for_serie(id_serie, db, current_user)

@app.get("/repetitions/{id_repetition}", tags=["Répétitions"], summary="Get a repetition by ID")
async def get_repetition(id_repetition: int, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await repetitions.get_repetition_by_id(id_repetition, db, current_user)

@app.post("/repetitions/", tags=["Répétitions"], summary="Create a repetition")
async def create_repetition(repetition: schemas.RepetitionCreate, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await repetitions.create_repetition(repetition, db, current_user)

@app.put("/repetitions/{id_repetition}", tags=["Répétitions"], summary="Update a repetition")
async def update_repetition(id_repetition: int, update_data: schemas.RepetitionUpdate, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await repetitions.update_repetition(id_repetition, update_data, db, current_user)

@app.delete("/repetitions/{id_repetition}", tags=["Répétitions"], summary="Delete a repetition")
async def delete_repetition(id_repetition: int, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await repetitions.delete_repetition(id_repetition, db, current_user)

# --- Programmes ---

@app.post("/programmes/", response_model=schemas.ProgrammeResponse, tags=["Programmes"])
async def create_programme(payload: schemas.ProgrammeCreate, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await programmes.create_programme(payload, db, current_user)

@app.get("/programmes/", response_model=list[schemas.ProgrammeResponse], tags=["Programmes"])
async def get_my_programmes(db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await programmes.get_my_programmes(db, current_user)

@app.get("/programmes/{programme_id}", response_model=schemas.ProgrammeResponse, tags=["Programmes"])
async def get_programme(programme_id: int, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await programmes.get_programme(programme_id, db, current_user)

@app.put("/programmes/{programme_id}", tags=["Programmes"])
async def update_programme(programme_id: int, payload: schemas.ProgrammeUpdate, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await programmes.update_programme(programme_id, payload, db, current_user)

@app.delete("/programmes/{programme_id}", tags=["Programmes"])
async def delete_programme(programme_id: int, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await programmes.delete_programme(programme_id, db, current_user)

# --- Programme Exercices ---

@app.post("/programme_exercices/", response_model=schemas.ProgrammeExerciceResponse, tags=["Programme Exercices"])
async def create_programme_exercice(payload: schemas.ProgrammeExerciceCreate, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await programmes.create_programme_exercice(payload, db, current_user)

@app.get("/programmes/{programme_id}/exercices", response_model=list[schemas.ProgrammeExerciceResponse], tags=["Programme Exercices"])
async def get_programme_exercices(programme_id: int, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await programmes.get_programme_exercices(programme_id, db, current_user)

@app.put("/programme_exercices/{pe_id}", tags=["Programme Exercices"])
async def update_programme_exercice(pe_id: int, payload: schemas.ProgrammeExerciceUpdate, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await programmes.update_programme_exercice(pe_id, payload, db, current_user)

@app.delete("/programme_exercices/{pe_id}", tags=["Programme Exercices"])
async def delete_programme_exercice(pe_id: int, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await programmes.delete_programme_exercice(pe_id, db, current_user)

@app.post("/programmes/full", response_model=schemas.ProgrammeFullResponse, tags=["Programmes"])
async def create_full_programme(payload: schemas.ProgrammeFullCreate, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    """
    Crée un programme et tous ses exercices associés en une seule fois.
    """
    return await programmes.create_full_programme(payload, db, current_user)

@app.get("/programmes/full", response_model=list[schemas.ProgrammeFullResponse], tags=["Programmes"])
async def get_my_full_programmes(db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    """
    Récupère TOUS les programmes de l'utilisateur avec leurs exercices respectifs.
    """
    return await programmes.get_my_full_programmes(db, current_user)

@app.get("/programmes/{programme_id}/full", response_model=schemas.ProgrammeFullResponse, tags=["Programmes"])
async def get_full_programme(programme_id: int, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    """
    Récupère un programme complet avec tous ses exercices.
    """
    return await programmes.get_full_programme(programme_id, db, current_user)

@app.put("/programmes/{programme_id}/full", response_model=schemas.ProgrammeFullResponse, tags=["Programmes"])
async def update_full_programme(programme_id: int, payload: schemas.ProgrammeFullUpdate, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    """
    Met à jour un programme (infos et liste d'exercices) en une seule fois.
    La synchronisation des exercices remplace l'ancienne liste par la nouvelle.
    """
    return await programmes.update_full_programme(programme_id, payload, db, current_user)

if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8001)
