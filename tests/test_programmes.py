import pytest
from fastapi import status

@pytest.fixture
def auth_headers(client):
    # Create user
    email = "prog@example.com"
    password = "password123"
    client.post(
        "/users/",
        json={
            "nom": "Prog",
            "prenom": "User",
            "email": email,
            "mot_de_passe": password,
            "date_naissance": "1990-01-01",
            "poids_corps": 75.0,
            "sexe": "M"
        }
    )
    # Login
    response = client.post(
        "/login",
        data={"username": email, "password": password}
    )
    if response.status_code != 200:
         pytest.fail(f"Login failed during setup: {response.json()}")
         
    token = response.json()["access_token"]
    return {"Authorization": f"Bearer {token}"}

def test_create_programme(client, auth_headers):
    # Note: the current service/query layer might return a list of mappings
    # but the API response_model might expect a single object.
    # We test the actual API response here.
    response = client.post(
        "/programmes/",
        json={"nom_programme": "Full Body", "description": "3 jours par semaine"},
        headers=auth_headers
    )
    assert response.status_code == status.HTTP_200_OK
    data = response.json()
    if isinstance(data, list):
        data = data[0]
    assert data["nom_programme"] == "Full Body"
    assert "id" in data

def test_get_programmes(client, auth_headers):
    # Create one first
    client.post(
        "/programmes/",
        json={"nom_programme": "Split", "description": "Hypertrophie"},
        headers=auth_headers
    )
    
    response = client.get("/programmes/", headers=auth_headers)
    assert response.status_code == status.HTTP_200_OK
    assert len(response.json()) >= 1

def test_unauthorized_access(client):
    response = client.get("/programmes/")
    assert response.status_code == status.HTTP_401_UNAUTHORIZED

def test_add_exercice_to_programme(client, auth_headers):
    # Create programme
    prog_resp = client.post(
        "/programmes/",
        json={"nom_programme": "VBT Basics", "description": "Test VBT"},
        headers=auth_headers
    )
    prog_id = prog_resp.json()["id"]
    
    # Add exercice
    response = client.post(
        "/programme_exercices/",
        json={
            "id_programme": prog_id,
            "id_exercice": 1,
            "ordre_passage": 1,
            "nombre_series": 3,
            "nombre_reps": 8,
            "charge_prevue": 100.0,
            "rpe_cible": 8.0
        },
        headers=auth_headers
    )
    assert response.status_code == status.HTTP_200_OK
    assert response.json()["id_programme"] == prog_id
    assert response.json()["id_exercice"] == 1

def test_get_programme_exercices(client, auth_headers):
    # Create programme
    prog_resp = client.post(
        "/programmes/",
        json={"nom_programme": "VBT Advanced", "description": "Test VBT"},
        headers=auth_headers
    )
    prog_id = prog_resp.json()["id"]
    
    # Add two exercices
    client.post(
        "/programme_exercices/",
        json={
            "id_programme": prog_id,
            "id_exercice": 1,
            "ordre_passage": 2, # Second
            "nombre_series": 3,
            "nombre_reps": 8
        },
        headers=auth_headers
    )
    client.post(
        "/programme_exercices/",
        json={
            "id_programme": prog_id,
            "id_exercice": 2,
            "ordre_passage": 1, # First
            "nombre_series": 3,
            "nombre_reps": 8
        },
        headers=auth_headers
    )
    
    response = client.get(f"/programmes/{prog_id}/exercices", headers=auth_headers)
    assert response.status_code == status.HTTP_200_OK
    data = response.json()
    assert len(data) == 2
    # Verify sorting by ordre_passage
    assert data[0]["ordre_passage"] == 1
    assert data[1]["ordre_passage"] == 2
