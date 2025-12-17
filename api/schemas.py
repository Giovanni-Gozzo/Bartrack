from pydantic import BaseModel, Field,EmailStr
from typing import List, Dict, Any,Optional
from datetime import date

class InitRequest(BaseModel):
    idexercice: str = Field(..., description="Id de l'exercice")
    rpe_low: float = Field(..., description="RPE le plus petit")
    rpe_high: float = Field(..., description="RPE le plus grand")
    speed_low: float = Field(..., gt=0, description="Vitesse correspondant au RPE le plus petit")
    speed_high: float = Field(..., gt=0, description="Vitesse correspondant au RPE le plus grand")

class ComputeRpeRequest(BaseModel):
    idexercice: str = Field(..., description="Id de l'exercice")
    speed: float = Field(..., description="Vitesse pour le calcul du RPE")

class PoidsRPE(BaseModel):
    idexercice: str = Field(..., description="Id de l'exercice")
    rpe: float = Field(..., description="RPE perçu")
    nbrep: int = Field(..., description="Nombre de répétitions")

class GenericQueryRequest(BaseModel):
    table_name: str
    columns: List[str] = ["*"]
    conditions: Dict[str, Any] = {}

class GenericUpdateRequest(BaseModel):
    table_name: str
    updates: Dict[str, Any]
    conditions: Dict[str, Any] = {}

class GenericCreateRequest(BaseModel):
    table_name: str
    data: Dict[str, Any]

class UserCreate(BaseModel):
    nom: str
    prenom: str
    email: EmailStr
    mot_de_passe: str
    date_naissance: date
    poids_corps: float
    sexe: str

class Rm1Users(BaseModel):
    id_exercice: int = Field(..., description="Id de l'exercice")
    current_1rm: float = Field(..., description="1RM actuelle")

class LoginRequest(BaseModel):
    email: EmailStr
    mot_de_passe: str