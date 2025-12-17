import sys
import os

# Ensure we can import from api
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

try:
    from api.sql_alchemy import engine, metadata
    from sqlalchemy import inspect
    
    print("Attempting to connect to database...")
    print(f"URL: {engine.url}") # Be careful not to expose password in logs if possible, but for local debug it helps to see if variables are loaded.
    
    inspector = inspect(engine)
    tables = inspector.get_table_names()
    
    print("Connection Successful!")
    print(f"Available tables: {tables}")

except Exception as e:
    print(f"\nConnection FAILED.")
    print(f"Error type: {type(e).__name__}")
    print(f"Error message: {str(e)}")
