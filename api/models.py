from sqlalchemy import Column, Integer, String, Date, Float, ForeignKey
from api.database import Base

class Utilisateur(Base):
    __tablename__ = "utilisateur"

    id = Column("id_utilisateur", Integer, primary_key=True, index=True)
    nom = Column(String)
    prenom = Column(String)
    email = Column(String, unique=True, index=True)
    mot_de_passe = Column(String)
    date_naissance = Column(Date)
    poids_corps = Column(Float)
    sexe = Column(String)
    role = Column(String)
    id_coach = Column(Integer, ForeignKey("utilisateur.id_utilisateur"), nullable=True)
