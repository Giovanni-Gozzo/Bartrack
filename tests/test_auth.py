import pytest
from fastapi import status

def test_register_user(client):
    response = client.post(
        "/users/",
        json={
            "nom": "Test",
            "prenom": "User",
            "email": "test@example.com",
            "mot_de_passe": "password123",
            "date_naissance": "1990-01-01",
            "poids_corps": 75.0,
            "sexe": "M"
        }
    )
    assert response.status_code == status.HTTP_200_OK
    assert response.json() == "coucou c'est créé"

def test_login_user(client):
    # Register first
    client.post(
        "/users/",
        json={
            "nom": "Login",
            "prenom": "Test",
            "email": "login@example.com",
            "mot_de_passe": "password123",
            "date_naissance": "1990-01-01",
            "poids_corps": 75.0,
            "sexe": "M"
        }
    )
    
    # Login
    response = client.post(
        "/login",
        data={"username": "login@example.com", "password": "password123"}
    )
    # Check if login is successful
    if response.status_code != 200:
        print(f"Login failed: {response.json()}")
    
    assert response.status_code == status.HTTP_200_OK
    assert "access_token" in response.json()
    assert response.json()["token_type"] == "bearer"

def test_login_invalid_credentials(client):
    response = client.post(
        "/login",
        data={"username": "wrong@example.com", "password": "password123"}
    )
    assert response.status_code == status.HTTP_401_UNAUTHORIZED
