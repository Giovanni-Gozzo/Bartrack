from sqlalchemy import Table, select, update, insert
from sqlalchemy.orm import Session
from fastapi import HTTPException
from api import schemas, database


def _load_table(table_name: str, db: Session) -> Table:
    if table_name not in database.metadata.tables:
        _refresh_table(table_name, db)
    return database.metadata.tables[table_name]


def _refresh_table(table_name: str, db: Session) -> Table:
    try:
        return Table(table_name, database.metadata, autoload_with=db.get_bind(), extend_existing=True)
    except Exception as e:
        raise HTTPException(status_code=400, detail=f"Table '{table_name}' not found or error loading it: {str(e)}")


def _ensure_columns(table: Table, col_names: list, db: Session) -> Table:
    """Rafraîchit le cache si une colonne est absente (ex: ALTER TABLE récent)."""
    if any(c not in table.columns for c in col_names):
        table = _refresh_table(table.name, db)
    return table


async def execute_generic_create(request: schemas.GenericCreateRequest, db: Session):
    table = _load_table(request.table_name, db)
    table = _ensure_columns(table, list(request.data.keys()), db)

    for col_name in request.data.keys():
        if col_name not in table.columns:
            raise HTTPException(status_code=400, detail=f"Column '{col_name}' not found in table '{request.table_name}'")

    stmt = insert(table).values(request.data)

    try:
        stmt = stmt.returning(table)
    except:
        pass

    try:
        result = db.execute(stmt)
        db.commit()
        data = [dict(row) for row in result.mappings().all()]
        return data
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")


async def execute_generic_update(request: schemas.GenericUpdateRequest, db: Session):
    table = _load_table(request.table_name, db)
    all_cols = list(request.updates.keys()) + list(request.conditions.keys())
    table = _ensure_columns(table, all_cols, db)

    for col_name in request.updates.keys():
        if col_name not in table.columns:
            raise HTTPException(status_code=400, detail=f"Column '{col_name}' to update not found in table '{request.table_name}'")

    stmt = update(table).values(request.updates)

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
    table = _load_table(request.table_name, db)
    checked_cols = [] if "*" in request.columns else request.columns
    table = _ensure_columns(table, checked_cols + list(request.conditions.keys()), db)

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
    from sqlalchemy import delete

    table = _load_table(request.table_name, db)
    table = _ensure_columns(table, list(request.conditions.keys()), db)

    if not request.conditions:
        raise HTTPException(status_code=400, detail="DELETE operation requires condition(s) to avoid deleting all data")

    stmt = delete(table)

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
