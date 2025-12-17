from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base
import os
from dotenv import load_dotenv

load_dotenv()

# Configuration de la base de données
USER = os.getenv("postgres_user")
PASSWORD = os.getenv("postgres_password")
HOST = os.getenv("postgres_host")
PORT = os.getenv("postgres_port")
DBNAME = os.getenv("postgres_dbname")

SQLALCHEMY_DATABASE_URL = f"postgresql+psycopg://{USER}:{PASSWORD}@{HOST}:{PORT}/{DBNAME}?sslmode=require"

engine = create_engine(SQLALCHEMY_DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

# Dépendance pour l'API
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()