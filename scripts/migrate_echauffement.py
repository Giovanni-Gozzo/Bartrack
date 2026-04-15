from sqlalchemy import create_engine, text
import os
from dotenv import load_dotenv

# Load env from root
env_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), ".env")
load_dotenv(env_path)

USER = os.getenv("postgres_user")
PASSWORD = os.getenv("postgres_password")
HOST = os.getenv("postgres_host")
PORT = os.getenv("postgres_port")
DBNAME = os.getenv("postgres_dbname")

DATABASE_URL = f"postgresql+psycopg://{USER}:{PASSWORD}@{HOST}:{PORT}/{DBNAME}?sslmode=require"

engine = create_engine(DATABASE_URL)

def migrate():
    with engine.connect() as conn:
        print("Connecting to database...")
        # Check if column exists
        check_query = text("""
            SELECT count(*) 
            FROM information_schema.columns 
            WHERE table_name = 'programme_exercice' AND column_name = 'echauffement'
        """)
        result = conn.execute(check_query).scalar()
        
        if result == 0:
            print("Adding column 'echauffement' to 'programme_exercice'...")
            conn.execute(text("ALTER TABLE programme_exercice ADD COLUMN echauffement BOOLEAN DEFAULT FALSE"))
            conn.commit()
            print("Column added successfully.")
        else:
            print("Column 'echauffement' already exists.")

if __name__ == "__main__":
    migrate()
