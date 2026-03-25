import pytest
from fastapi import status

@pytest.fixture
def auth_headers(client):
    email = "profile@example.com"
    password = "password123"
    client.post(
        "/users/",
        json={
            "nom": "Profile",
            "prenom": "User",
            "email": email,
            "mot_de_passe": password,
            "date_naissance": "1990-01-01",
            "poids_corps": 75.0,
            "sexe": "M"
        }
    )
    response = client.post("/login", data={"username": email, "password": password})
    token = response.json()["access_token"]
    return {"Authorization": f"Bearer {token}"}

def test_get_my_profile(client, auth_headers):
    response = client.get("/users/me", headers=auth_headers)
    assert response.status_code == status.HTTP_200_OK
    assert response.json()["email"] == "profile@example.com"

def test_get_profile_unauthorized(client):
    response = client.get("/users/me")
    assert response.status_code == status.HTTP_401_UNAUTHORIZED

def test_update_my_profile(client, auth_headers):
    response = client.put(
        "/users/me",
        json={"poids_corps": 80.0, "nom": "UpdatedName"},
        headers=auth_headers
    )
    assert response.status_code == status.HTTP_200_OK
    data = response.json()
    assert data["poids_corps"] == 80.0
    assert data["nom"] == "UpdatedName"

def test_update_profile_invalid_data(client, auth_headers):
    # poids_corps should be a number
    response = client.put(
        "/users/me",
        json={"poids_corps": "not-a-number"},
        headers=auth_headers
    )
    assert response.status_code == status.HTTP_422_UNPROCESSABLE_ENTITY
