from sqlalchemy import Table, select, MetaData, update, insert
from sqlalchemy.orm import Session
from fastapi import HTTPException
from api import schemas, database

async def execute_generic_create(request: schemas.GenericCreateRequest, db: Session):
    """
    Executes an INSERT query on the specified table.
    """
    # Check if table is already loaded in metadata
    if request.table_name in database.metadata.tables:
        table = database.metadata.tables[request.table_name]
    else:
        try:
            table = Table(request.table_name, database.metadata, autoload_with=db.get_bind())
        except Exception as e:
            raise HTTPException(status_code=400, detail=f"Table '{request.table_name}' not found or error loading it: {str(e)}")

    # Validate columns
    for col_name in request.data.keys():
        if col_name not in table.columns:
            raise HTTPException(status_code=400, detail=f"Column '{col_name}' not found in table '{request.table_name}'")

    stmt = insert(table).values(request.data)
    
    # Try to return the inserted row (works with Postgres)
    try:
        stmt = stmt.returning(table)
    except:
        pass # Fallback if not supported (though we know it's postgres)

    try:
        result = db.execute(stmt)
        db.commit()
        # Convert rows to list of dicts (should be size 1)
        data = [dict(row) for row in result.mappings().all()]
        return data
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")

async def execute_generic_update(request: schemas.GenericUpdateRequest, db: Session):
    """
    Executes an UPDATE query on the specified table.
    """
    # Check if table is already loaded in metadata
    if request.table_name in database.metadata.tables:
        table = database.metadata.tables[request.table_name]
    else:
        try:
            table = Table(request.table_name, database.metadata, autoload_with=db.get_bind())
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
            table = Table(request.table_name, database.metadata, autoload_with=db.get_bind())
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

async def execute_generic_delete(request: schemas.GenericDeleteRequest, db: Session):
    """
    Executes a DELETE query on the specified table.
    """
    from sqlalchemy import delete
    
    # Check if table is already loaded in metadata
    if request.table_name in database.metadata.tables:
        table = database.metadata.tables[request.table_name]
    else:
        try:
            table = Table(request.table_name, database.metadata, autoload_with=db.get_bind())
        except Exception as e:
            raise HTTPException(status_code=400, detail=f"Table '{request.table_name}' not found or error loading it: {str(e)}")

    if not request.conditions:
        raise HTTPException(status_code=400, detail="DELETE operation requires condition(s) to avoid deleting all data")
        
    stmt = delete(table)

    # Add conditions
    for col_name, value in request.conditions.items():
        if col_name not in table.columns:
            raise HTTPException(status_code=400, detail=f"Column '{col_name}' used in condition not found")
        stmt = stmt.where(table.columns[col_name] == value)

    try:
        result = db.execute(stmt)
        db.commit()
        if result.rowcount == 0:
            raise HTTPException(status_code=404, detail="No row matched the given conditions for deletion")
        return {"rows_affected": result.rowcount, "message": "Delete successful"}
    except HTTPException:
        raise
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
