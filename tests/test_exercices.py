import pytest
from fastapi import status

@pytest.fixture
def admin_headers(client, db_session):
    email = "admin@example.com"
    password = "password123"
    client.post(
        "/users/",
        json={
            "nom": "Admin",
            "prenom": "User",
            "email": email,
            "mot_de_passe": password,
            "date_naissance": "1990-01-01",
            "poids_corps": 80.0,
            "sexe": "M"
        }
    )
    # Manually update role in test DB to 'admin'
    from sqlalchemy import text
    db_session.execute(text("UPDATE utilisateur SET role = 'admin' WHERE email = :email"), {"email": email})
    db_session.commit()
        
    response = client.post("/login", data={"username": email, "password": password})
    token = response.json()["access_token"]
    return {"Authorization": f"Bearer {token}"}

@pytest.fixture
def user_headers(client):
    email = "user@example.com"
    password = "password123"
    client.post(
        "/users/",
        json={
            "nom": "Simple",
            "prenom": "User",
            "email": email,
            "mot_de_passe": password,
            "date_naissance": "1990-01-01",
            "poids_corps": 70.0,
            "sexe": "F"
        }
    )
    response = client.post("/login", data={"username": email, "password": "pwd"}) # Wait, pwd or password123?
    # In register it's password123.
    response = client.post("/login", data={"username": email, "password": "password123"})
    token = response.json()["access_token"]
    return {"Authorization": f"Bearer {token}"}

def test_get_all_exercices(client, db_session):
    # First add an exercice
    from sqlalchemy import text
    db_session.execute(text("INSERT INTO exercice (nom, description) VALUES ('Squat', 'Barbell Back Squat')"))
    db_session.commit()
        
    response = client.get("/exercices/")
    assert response.status_code == status.HTTP_200_OK
    assert len(response.json()) >= 1
    # The return columns might be id_exercice and nom based on service line 9
    assert response.json()[0]["nom"] == "Squat"

def test_create_exercice_admin(client, admin_headers):
    response = client.post(
        "/exercices/",
        json={"nom": "Bench Press", "description": "Classic bench"},
        headers=admin_headers
    )
    assert response.status_code == status.HTTP_200_OK
    assert response.json()["nom"] == "Bench Press"

def test_create_exercice_non_admin(client, user_headers):
    response = client.post(
        "/exercices/",
        json={"nom": "Deadlift", "description": "Heavy lift"},
        headers=user_headers
    )
    assert response.status_code in [status.HTTP_403_FORBIDDEN, status.HTTP_401_UNAUTHORIZED]
