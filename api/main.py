import uvicorn

from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field

app = FastAPI()

@app.get("/")
async def hello():
    return {"message": "Hello World"}

class InitRequest(BaseModel):
    idutilisateur: str = Field(..., description="Identifiant unique de l'utilisateur")
    exercice: str = Field(..., description="Nom de l'exercice")
    rpe_low: float = Field(..., description="RPE le plus petit")
    rpe_high: float = Field(..., description="RPE le plus grand")
    speed_low: float = Field(..., gt=0, description="Vitesse correspondant au RPE le plus petit")
    speed_high: float = Field(..., gt=0, description="Vitesse correspondant au RPE le plus grand")

# Endpoint pour initialiser les paramètres utilisateurs
@app.post(
    "/initialize",
    summary="Initialize the system with given parameters",
    description=(
        "Calcule le slope et l'intercept à partir des deux paires (RPE, vitesse). "
        "La formule est: slope = (rpe_high - rpe_low) / (speed_high - speed_low). "
        "Intercept = rpe_high - slope * speed_high."
    ),
)
async def initialize(payload: InitRequest):
    """Calcule le slope et l'intercept selon la formule fournie.

    Retourne:
      - slope
      - intercept
      - inputs (echo des valeurs reçues)
    """
    rpe_low = payload.rpe_low
    rpe_high = payload.rpe_high
    v_low = payload.speed_low
    v_high = payload.speed_high

    if rpe_high <= rpe_low:
        raise HTTPException(status_code=400, detail="rpe_high doit être strictement supérieur à rpe_low.")
    if v_high == v_low:
        raise HTTPException(status_code=400, detail="Les vitesses doivent être différentes pour calculer le slope.")

    slope = (rpe_high - rpe_low) / (v_high - v_low)
    intercept = rpe_high - slope * v_high

    #mettre a jour dans la bd pour l'utilisateur et l'exercice

    return {
        "slope": slope,
        "intercept": intercept,
        "inputs": {
            "rpe_low": rpe_low,
            "rpe_high": rpe_high,
            "speed_low": v_low,
            "speed_high": v_high,
        },
    }

class ComputeRpeRequest(BaseModel):
    idutilisateur: str = Field(..., description="Identifiant unique de l'utilisateur")
    exercice: str = Field(..., description="Nom de l'exercice")
    speed: float = Field(..., description="Vitesse pour le calcul du RPE")

#Endpoint pour calculer le RPE après chaque série poru adapter le poids si besoin
@app.post(
    "/compute_rpe",
    summary="Compute RPE from speed, slope and intercept",
    description="Calcule le RPE selon la formule rpe = slope * speed + intercept",
)
async def compute_rpe(payload: ComputeRpeRequest):
    """Calcule et renvoie le RPE à partir de speed, slope et intercept."""

    # Récupérer slope et intercept depuis la base de données pour l'utilisateur et l'exercice
    slope=
    intercept=

    rpe = slope * payload.speed + intercept

    return {"rpe": rpe, "inputs": {"speed": payload.speed, "slope": payload.slope, "intercept": payload.intercept}}

class poidsRPE(BaseModel):
    idutilisateur: str = Field(..., description="Identifiant unique de l'utilisateur")
    exercice: str = Field(..., description="Nom de l'exercice")
    rpe: float = Field(..., description="RPE perçu")

# Endpoint pour calculer le poids à utiliser en fonction du RPE et du 1RM
@app.post(
    "/compute_weight",
    summary="Compute weight from 1RM and RPE")

#a faire avec la tableau dans la base requeté


if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8000)
