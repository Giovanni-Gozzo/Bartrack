from sqlalchemy import inspect
from database import engine
import sys

def check_db():
    print("Connecting to database...")
    try:
        inspector = inspect(engine)
        tables = inspector.get_table_names()
        print(f"Successfully connected.")
        print(f"Tables found in database '{engine.url.database}':")
        for t in tables:
            print(f" - {t}")
        
        if "utilisateur" in tables:
            print("\nTable 'utilisateur' FOUND. Columns:")
            columns = inspector.get_columns("utilisateur")
            for c in columns:
                print(f" - {c['name']} ({c['type']})")
        elif "utilisateurs" in tables:
            print("\nTable 'utilisateurs' FOUND (note plural).")
        else:
            print("\nTable 'utilisateur' NOT FOUND.")
            
    except Exception as e:
        print(f"Error connecting or inspecting DB: {e}")

if __name__ == "__main__":
    check_db()
