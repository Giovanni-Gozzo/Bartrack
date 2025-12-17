from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
from . import crud, schemas, database, models

app = FastAPI()


@app.post("/users/", response_model=schemas.UserCreate)
def register_user(user: schemas.UserCreate, db: Session = Depends(database.get_db)):
    # Vérification d'existence
    db_user = db.query(models.Utilisateur).filter(models.Utilisateur.email == user.email).first()
    if db_user:
        raise HTTPException(status_code=400, detail="Email déjà enregistré")

    return crud.create_user(db=db, user=user)