from sqlalchemy import create_engine, MetaData
from sqlalchemy.orm import sessionmaker
from dotenv import load_dotenv
import os

# Load environment variables from .env
load_dotenv(os.path.join(os.path.dirname(__file__), ".env"))

# Fetch variables
USER = os.getenv("postgres_user")
PASSWORD = os.getenv("postgres_password")
HOST = os.getenv("postgres_host")
PORT = os.getenv("postgres_port")
DBNAME = os.getenv("postgres_dbname")

DATABASE_URL = f"postgresql+psycopg2://{USER}:{PASSWORD}@{HOST}:{PORT}/{DBNAME}?sslmode=require"

# Create the SQLAlchemy engine
engine = create_engine(DATABASE_URL)

# SessionLocal for dependency injection
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Metadata for table reflection
metadata = MetaData()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()