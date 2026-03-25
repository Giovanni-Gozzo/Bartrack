import pytest
from fastapi import status

@pytest.fixture
def auth_headers_user1(client):
    email = "user1@example.com"
    client.post("/users/", json={"nom": "U1", "prenom": "User", "email": email, "mot_de_passe": "pwd", "date_naissance": "1990-01-01", "poids_corps": 70.0, "sexe": "M"})
    response = client.post("/login", data={"username": email, "password": "pwd"})
    return {"Authorization": f"Bearer {response.json()['access_token']}"}

@pytest.fixture
def auth_headers_user2(client):
    email = "user2@example.com"
    client.post("/users/", json={"nom": "U2", "prenom": "User", "email": email, "mot_de_passe": "pwd", "date_naissance": "1990-01-01", "poids_corps": 70.0, "sexe": "F"})
    response = client.post("/login", data={"username": email, "password": "pwd"})
    return {"Authorization": f"Bearer {response.json()['access_token']}"}

def test_create_seance(client, auth_headers_user1):
    response = client.post("/seances/", json={"date_seance": "2026-03-25"}, headers=auth_headers_user1)
    assert response.status_code == status.HTTP_200_OK
    assert response.json()["date_seance"] == "2026-03-25"

def test_get_seances_isolation(client, auth_headers_user1, auth_headers_user2):
    # User 1 creates a seance
    client.post("/seances/", json={"date_seance": "2026-03-25"}, headers=auth_headers_user1)
    
    # User 2 should NOT see it
    response = client.get("/seances/", headers=auth_headers_user2)
    assert response.status_code == status.HTTP_200_OK
    assert len(response.json()) == 0
    
    # User 1 SHOULD see it
    response = client.get("/seances/", headers=auth_headers_user1)
    assert len(response.json()) == 1

def test_get_seance_by_id_unauthorized(client, auth_headers_user1, auth_headers_user2):
    client.post("/seances/", json={"date_seance": "2026-03-25"}, headers=auth_headers_user1)
    s_id = client.get("/seances/", headers=auth_headers_user1).json()[0]["id_seance"]
    
    response = client.get(f"/seances/{s_id}", headers=auth_headers_user2)
    assert response.status_code == status.HTTP_404_NOT_FOUND

def test_add_exo_to_seance(client, auth_headers_user1, db_session):
    # 1. Create seance
    client.post("/seances/", json={"date_seance": "2026-03-25"}, headers=auth_headers_user1)
    s_id = client.get("/seances/", headers=auth_headers_user1).json()[0]["id_seance"]
    
    # 2. Add exercice
    from sqlalchemy import text
    db_session.execute(text("INSERT INTO exercice (id_exercice, nom) VALUES (1, 'Squat')"))
    db_session.commit()
        
    response = client.post(
        "/seance_exos/",
        json={"id_seance": s_id, "id_exercice": 1, "daily_1rm": 100.0, "charge_reelle": 80.0, "rpe_souhaite": 8.0, "ordre_passage": 1},
        headers=auth_headers_user1
    )
    assert response.status_code == status.HTTP_200_OK
    assert response.json()["message"] == "Exercice ajouté à la séance avec succès"

def test_create_seance_invalid_date(client, auth_headers_user1):
    response = client.post("/seances/", json={"date_seance": "not-a-date"}, headers=auth_headers_user1)
    assert response.status_code == status.HTTP_422_UNPROCESSABLE_ENTITY

def test_delete_seance(client, auth_headers_user1):
    client.post("/seances/", json={"date_seance": "2026-03-25"}, headers=auth_headers_user1)
    s_id = client.get("/seances/", headers=auth_headers_user1).json()[0]["id_seance"]
    
    response = client.delete(f"/seances/{s_id}", headers=auth_headers_user1)
    assert response.status_code == status.HTTP_200_OK
    
    # Verify it's gone
    response = client.get(f"/seances/{s_id}", headers=auth_headers_user1)
    assert response.status_code == status.HTTP_404_NOT_FOUND
