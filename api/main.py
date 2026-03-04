import uvicorn
from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session
from api.database import get_db
from api import schemas, auth
from api.services import calculations, query, users
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
    summary="Compute RPE from speed, slope and intercept",
    description="Calcule le RPE selon la formule rpe = slope * speed + intercept",
)
async def compute_rpe(payload: schemas.ComputeRpeRequest, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await calculations.calculate_rpe(payload, db, current_user)

@app.post(
    "/compute_weight",
    summary="Compute weight from 1RM and RPE")
async def compute_weight(payload: schemas.PoidsRPE, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await calculations.calculate_weight(payload, db, current_user)

@app.post("/generic_query", summary="Generic database query")
async def generic_query(request: schemas.GenericQueryRequest, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    """
    Executes a SELECT query on the specified table.
    """
    return await query.execute_generic_query(request, db)

@app.post("/generic_update", summary="Generic database update")
async def generic_update(request: schemas.GenericUpdateRequest, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    """
    Executes an UPDATE query on the specified table.
    """
    return await query.execute_generic_update(request, db)

@app.post("/generic_create", summary="Generic database create")
async def generic_create(request: schemas.GenericCreateRequest, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    """
    Executes an INSERT query on the specified table.
    """
    return await query.execute_generic_create(request, db)

@app.post("/users/")
async def register_user(user: schemas.UserCreate, db: Session = Depends(get_db)):
    return await users.register_new_user(user, db)

@app.post("/rm1_users/")
async def rm1_users(users_req: schemas.Rm1Users, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await users.rm1_users(users_req, db, current_user)

@app.post("/daily_1rm/")
async def daily_1rm(users_req: schemas.Daily1rmRequest, db: Session = Depends(get_db), current_user: str = Depends(auth.get_current_user)):
    return await calculations.calculate_daily_1rm(users_req, db, current_user)

@app.post("/login", summary="Login user")
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

if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8001)
