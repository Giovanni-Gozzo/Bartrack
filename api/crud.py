from sqlalchemy.orm import Session
from . import models, schemas, auth


def create_user(db: Session, user: schemas.UserCreate):
    hashed_pwd = auth.hash_password(user.mot_de_passe)

    db_user = models.Utilisateur(
        nom=user.nom,
        prenom=user.prenom,
        email=user.email,
        mot_de_passe=hashed_pwd,
        date_naissance=user.date_naissance,
        poids_corps=user.poids_corps,
        sexe=user.sexe
    )

    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user