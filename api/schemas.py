from pydantic import BaseModel, Field,EmailStr
from typing import List, Dict, Any,Optional
from datetime import date, datetime

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
    RM1: float = Field(..., description="1RM actuelle")

class Daily1rmRequest(BaseModel):
    idexercice: str = Field(..., description="Id de l'exercice")
    id_seance_exo: int = Field(..., description="Id de la liaison séance-exercice")
    nbrep: int = Field(..., description="Nombre de répétitions")
    poidsbarre: float = Field(..., description="Poids de la barre")
    vitesse: float = Field(..., description="Vitesse de la barre")
    
class GenericQueryRequest(BaseModel):
    table_name: str
    columns: List[str] = ["*"]
    conditions: Dict[str, Any] = {}

class GenericUpdateRequest(BaseModel):
    table_name: str
    updates: Dict[str, Any]
    conditions: Dict[str, Any] = {}

class GenericDeleteRequest(BaseModel):
    table_name: str
    conditions: Dict[str, Any]

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

class UserUpdate(BaseModel):
    nom: Optional[str] = None
    prenom: Optional[str] = None
    date_naissance: Optional[date] = None
    poids_corps: Optional[float] = None
    sexe: Optional[str] = None

class ExerciceCreate(BaseModel):
    nom: str

class ExerciceUpdate(BaseModel):
    nom: Optional[str] = None

class ExerciceResponse(BaseModel):
    id_exercice: int
    nom: str

class SeanceCreate(BaseModel):
    date_seance: date = Field(default_factory=date.today)

class SeanceUpdate(BaseModel):
    date_seance: Optional[date] = None
    
class SeanceResponse(BaseModel):
    id_seance: int
    id_utilisateur: int
    date_seance: date

class SeanceExoCreate(BaseModel):
    id_seance: int
    id_exercice: int
    daily_1rm: Optional[float] = None

class SeanceExoUpdate(BaseModel):
    id_seance: Optional[int] = None
    id_exercice: Optional[int] = None
    daily_1rm: Optional[float] = None

class SeanceExoResponse(BaseModel):
    id_seance_exo: int
    id_seance: int
    id_exercice: int
    daily_1rm: Optional[float] = None

class ProfilVbtCreate(BaseModel):
    id_exercice: int
    current_1rm: Optional[float] = None
    slope: Optional[float] = None
    intercept: Optional[float] = None

class ProfilVbtUpdate(BaseModel):
    current_1rm: Optional[float] = None
    slope: Optional[float] = None
    intercept: Optional[float] = None

class ProfilVbtResponse(BaseModel):
    id_utilisateur: int
    id_exercice: int
    current_1rm: Optional[float] = None
    slope: Optional[float] = None
    intercept: Optional[float] = None
    last_updated: Optional[datetime] = None

class SerieCreate(BaseModel):
    id_seance_exo: int
    charge_kg: Optional[float] = None
    nombre_reps: Optional[int] = None
    vitesse_fin_serie: Optional[float] = None
    rpe_estime: Optional[float] = None
    rpe_reel: Optional[float] = None
    echauffement: Optional[bool] = False

class SerieUpdate(BaseModel):
    charge_kg: Optional[float] = None
    nombre_reps: Optional[int] = None
    vitesse_fin_serie: Optional[float] = None
    rpe_estime: Optional[float] = None
    rpe_reel: Optional[float] = None
    echauffement: Optional[bool] = None

class SerieResponse(BaseModel):
    id: int
    id_seance_exo: int
    charge_kg: Optional[float] = None
    nombre_reps: Optional[int] = None
    vitesse_fin_serie: Optional[float] = None
    rpe_estime: Optional[float] = None
    rpe_reel: Optional[float] = None
    echauffement: Optional[bool] = None

class RepetitionCreate(BaseModel):
    id_serie: int
    numero_rep: Optional[int] = None
    vitesse_mesuree: Optional[float] = None

class RepetitionUpdate(BaseModel):
    numero_rep: Optional[int] = None
    vitesse_mesuree: Optional[float] = None

class RepetitionResponse(BaseModel):
    id: int
    id_serie: int
    numero_rep: Optional[int] = None
    vitesse_mesuree: Optional[float] = None

class RollingCalculationRequest(BaseModel):
    id_exercice: int

# --- Programme Schemas ---
class ProgrammeBase(BaseModel):
    nom_programme: str
    description: Optional[str] = None

class ProgrammeCreate(ProgrammeBase):
    pass

class ProgrammeUpdate(BaseModel):
    nom_programme: Optional[str] = None
    description: Optional[str] = None

class ProgrammeResponse(ProgrammeBase):
    id: int
    id_utilisateur: int
    date_creation: Optional[datetime] = None

    class Config:
        from_attributes = True

# --- ProgrammeExercice Schemas ---
class ProgrammeExerciceBase(BaseModel):
    id_programme: int
    id_exercice: int
    ordre_passage: int
    nombre_series: int
    nombre_reps: int
    charge_prevue: Optional[float] = None
    rpe_cible: Optional[float] = None
    echauffement: Optional[bool] = False

class ProgrammeExerciceCreate(ProgrammeExerciceBase):
    pass

class ProgrammeExerciceUpdate(BaseModel):
    id_exercice: Optional[int] = None
    ordre_passage: Optional[int] = None
    nombre_series: Optional[int] = None
    nombre_reps: Optional[int] = None
    charge_prevue: Optional[float] = None
    rpe_cible: Optional[float] = None

class ProgrammeExerciceResponse(ProgrammeExerciceBase):
    id: int

    class Config:
        from_attributes = True

# --- Unified Creation Schemas ---

class ProgrammeExerciceFullCreate(BaseModel):
    id_exercice: int
    ordre_passage: int
    nombre_series: int
    nombre_reps: int
    charge_prevue: Optional[float] = None
    rpe_cible: Optional[float] = None
    echauffement: Optional[bool] = False

class ProgrammeFullCreate(BaseModel):
    nom_programme: str
    description: Optional[str] = None
    exercices: List[ProgrammeExerciceFullCreate]

class ProgrammeFullUpdate(BaseModel):
    nom_programme: Optional[str] = None
    description: Optional[str] = None
    exercices: Optional[List[ProgrammeExerciceFullCreate]] = None

class ProgrammeFullResponse(ProgrammeResponse):
    exercices: List[ProgrammeExerciceResponse]