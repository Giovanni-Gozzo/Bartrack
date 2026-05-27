import pytest
from sqlalchemy import create_engine, Table, Column, Integer, String, Text, ForeignKey, DateTime, Numeric, Date, Boolean, Float
from sqlalchemy.orm import sessionmaker
from api.database import Base, get_db
from api.main import app
from fastapi.testclient import TestClient
import os
from datetime import datetime
from api import models # Ensure Utilisateur is in metadata

# Use a local SQLite database for testing
SQLALCHEMY_DATABASE_URL = "sqlite:///./test_bartrack.db"

engine = create_engine(
    SQLALCHEMY_DATABASE_URL, connect_args={"check_same_thread": False}
)
TestingSessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Manually define tables that use autoload in the app but need to exist for testing
# (Normally you'd define these in models.py, but we adapt to the existing architecture)

# --- Tables ---

exercice = Table(
    "exercice",
    Base.metadata,
    Column("id_exercice", Integer, primary_key=True),
    Column("nom", String(100)),
    Column("description", Text),
    extend_existing=True
)

seance = Table(
    "seance",
    Base.metadata,
    Column("id_seance", Integer, primary_key=True),
    Column("id_utilisateur", Integer, ForeignKey("utilisateur.id_utilisateur")),
    Column("date_seance", Date),
    extend_existing=True
)

seance_exo = Table(
    "seance_exo",
    Base.metadata,
    Column("id_seance_exo", Integer, primary_key=True),
    Column("id_seance", Integer, ForeignKey("seance.id_seance")),
    Column("id_exercice", Integer, ForeignKey("exercice.id_exercice")),
    Column("daily_1rm", Float),
    Column("charge_reelle", Float),
    Column("rpe_souhaite", Float),
    Column("ordre_passage", Integer),
    extend_existing=True
)

serie = Table(
    "serie",
    Base.metadata,
    Column("id", Integer, primary_key=True),
    Column("id_seance_exo", Integer, ForeignKey("seance_exo.id_seance_exo")),
    Column("charge_kg", Float),
    Column("nombre_reps", Integer),
    Column("vitesse_fin_serie", Float),
    Column("rpe_estime", Float),
    Column("rpe_reel", Float),
    Column("echauffement", Boolean),
    extend_existing=True
)

repetition = Table(
    "repetition",
    Base.metadata,
    Column("id", Integer, primary_key=True),
    Column("id_serie", Integer, ForeignKey("serie.id")),
    Column("numero_rep", Integer),
    Column("vitesse_mesuree", Float),
    extend_existing=True
)

profil_vbt = Table(
    "profil_vbt",
    Base.metadata,
    Column("id_utilisateur", Integer, ForeignKey("utilisateur.id_utilisateur"), primary_key=True),
    Column("id_exercice", Integer, ForeignKey("exercice.id_exercice"), primary_key=True),
    Column("slope", Float),
    Column("intercept", Float),
    Column("current_1rm", Float),
    Column("last_updated", DateTime, default=datetime.utcnow),
    extend_existing=True
)

programme = Table(
    "programme",
    Base.metadata,
    Column("id", Integer, primary_key=True),
    Column("id_utilisateur", Integer, ForeignKey("utilisateur.id_utilisateur")),
    Column("nom_programme", String(100)),
    Column("description", Text),
    Column("date_creation", DateTime, default=datetime.utcnow),
    extend_existing=True
)

programme_exercice = Table(
    "programme_exercice",
    Base.metadata,
    Column("id", Integer, primary_key=True),
    Column("id_programme", Integer, ForeignKey("programme.id")),
    Column("id_exercice", Integer, ForeignKey("exercice.id_exercice")),
    Column("ordre_passage", Integer),
    Column("nombre_series", Integer),
    Column("nombre_reps", Integer),
    Column("charge_prevue", Numeric(5, 2)),
    Column("rpe_cible", Numeric(3, 1)),
    Column("echauffement", Boolean, default=False),
    extend_existing=True
)


@pytest.fixture(scope="session", autouse=True)
def setup_database():
    # Create the tables
    Base.metadata.create_all(bind=engine)
    yield
    # Cleanup
    if os.path.exists("./test_bartrack.db"):
        try:
            os.remove("./test_bartrack.db")
        except:
            pass

@pytest.fixture
def db_session():
    connection = engine.connect()
    transaction = connection.begin()
    session = TestingSessionLocal(bind=connection)
    
    yield session
    
    session.close()
    if transaction.is_active:
        transaction.rollback()
    connection.close()

@pytest.fixture
def client(db_session):
    def override_get_db():
        try:
            yield db_session
        finally:
            pass
            
    app.dependency_overrides[get_db] = override_get_db
    with TestClient(app) as c:
        yield c
    app.dependency_overrides.clear()
