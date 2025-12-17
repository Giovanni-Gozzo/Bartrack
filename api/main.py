import uvicorn
from fastapi import FastAPI, Depends,HTTPException
from sqlalchemy.orm import Session
from api.database import get_db
from api import schemas
from api.services import calculations, query
from api import crud
from api import models
from api.database import Base
from fastapi.middleware.cors import CORSMiddleware

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
async def initialize(payload: schemas.InitRequest):
    return await calculations.initialize_profile(payload)

@app.post(
    "/compute_rpe",
    summary="Compute RPE from speed, slope and intercept",
    description="Calcule le RPE selon la formule rpe = slope * speed + intercept",
)
async def compute_rpe(payload: schemas.ComputeRpeRequest, db: Session = Depends(get_db)):
    return await calculations.calculate_rpe(payload, db)

@app.post(
    "/compute_weight",
    summary="Compute weight from 1RM and RPE")
async def compute_weight(payload: schemas.PoidsRPE, db: Session = Depends(get_db)):
    return await calculations.calculate_weight(payload, db)

@app.post("/generic_query", summary="Generic database query")
async def generic_query(request: schemas.GenericQueryRequest, db: Session = Depends(get_db)):
    """
    Executes a SELECT query on the specified table.
    """
    return await query.execute_generic_query(request, db)

@app.post("/generic_update", summary="Generic database update")
async def generic_update(request: schemas.GenericUpdateRequest, db: Session = Depends(get_db)):
    """
    Executes an UPDATE query on the specified table.
    """
    return await query.execute_generic_update(request, db)

@app.post("/users/", response_model=schemas.UserCreate)
def register_user(user: schemas.UserCreate, db: Session = Depends(get_db)):
    db_user = db.query(models.Utilisateur).filter(models.Utilisateur.email == user.email).first()
    if db_user:
        raise HTTPException(status_code=400, detail="Email déjà enregistré")

    return crud.create_user(db=db, user=user)

if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.0", port=8001)
