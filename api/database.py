from sqlalchemy import create_engine, MetaData
from sqlalchemy.orm import sessionmaker, declarative_base
from dotenv import load_dotenv
import os

load_dotenv(os.path.join(os.path.dirname(os.path.dirname(__file__)), ".env"))

USER = os.getenv("postgres_user")
PASSWORD = os.getenv("postgres_password")
HOST = os.getenv("postgres_host")
PORT = os.getenv("postgres_port")
DBNAME = os.getenv("postgres_dbname")

if all([USER, PASSWORD, HOST, PORT, DBNAME]):
    DATABASE_URL = f"postgresql+psycopg://{USER}:{PASSWORD}@{HOST}:{PORT}/{DBNAME}?sslmode=require"
else:
    DATABASE_URL = "sqlite:///./test_bartrack.db"

engine = create_engine(DATABASE_URL, connect_args={"check_same_thread": False} if "sqlite" in DATABASE_URL else {})

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

metadata = MetaData()
Base = declarative_base()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()