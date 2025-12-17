from sqlalchemy import Table, select, MetaData, update
from sqlalchemy.orm import Session
from fastapi import HTTPException
from api import schemas, database

async def execute_generic_update(request: schemas.GenericUpdateRequest, db: Session):
    """
    Executes an UPDATE query on the specified table.
    """
    # Check if table is already loaded in metadata
    if request.table_name in database.metadata.tables:
        table = database.metadata.tables[request.table_name]
    else:
        try:
            table = Table(request.table_name, database.metadata, autoload_with=database.engine)
        except Exception as e:
            raise HTTPException(status_code=400, detail=f"Table '{request.table_name}' not found or error loading it: {str(e)}")

    # Validate update columns
    for col_name in request.updates.keys():
        if col_name not in table.columns:
             raise HTTPException(status_code=400, detail=f"Column '{col_name}' to update not found in table '{request.table_name}'")

    stmt = update(table).values(request.updates)

    # Add conditions
    for col_name, value in request.conditions.items():
        if col_name not in table.columns:
            raise HTTPException(status_code=400, detail=f"Column '{col_name}' used in condition not found")
        stmt = stmt.where(table.columns[col_name] == value)

    try:
        result = db.execute(stmt)
        db.commit()
        return {"rows_affected": result.rowcount, "message": "Update successful"}
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")

async def execute_generic_query(request: schemas.GenericQueryRequest, db: Session):
    """
    Executes a SELECT query on the specified table.
    """
    # Check if table is already loaded in metadata
    if request.table_name in database.metadata.tables:
        table = database.metadata.tables[request.table_name]
    else:
        try:
            table = Table(request.table_name, database.metadata, autoload_with=database.engine)
        except Exception as e:
            raise HTTPException(status_code=400, detail=f"Table '{request.table_name}' not found or error loading it: {str(e)}")

    if "*" in request.columns:
        query = select(table)
    else:
        selected_columns = []
        for col_name in request.columns:
            if col_name not in table.columns:
                raise HTTPException(status_code=400, detail=f"Column '{col_name}' not found in table '{request.table_name}'")
            selected_columns.append(table.columns[col_name])
        query = select(*selected_columns)

    for col_name, value in request.conditions.items():
        if col_name not in table.columns:
            raise HTTPException(status_code=400, detail=f"Column '{col_name}' used in condition not found")
        query = query.where(table.columns[col_name] == value)

    try:
        result = db.execute(query)
        data = [dict(row) for row in result.mappings().all()]
        return data
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
