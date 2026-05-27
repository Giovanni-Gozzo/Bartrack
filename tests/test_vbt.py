import pytest
from fastapi import status

@pytest.fixture
def auth_headers(client):
    email = "vbt@example.com"
    client.post("/users/", json={"nom": "VBT", "prenom": "User", "email": email, "mot_de_passe": "pwd", "date_naissance": "1990-01-01", "poids_corps": 70.0, "sexe": "M"})
    response = client.post("/login", data={"username": email, "password": "pwd"})
    return {"Authorization": f"Bearer {response.json()['access_token']}"}

@pytest.fixture
def seance_exo_id(client, auth_headers, db_session):
    # Setup: Exercise, Seance, SeanceExo
    from sqlalchemy import text
    db_session.execute(text("INSERT INTO exercice (id_exercice, nom) VALUES (1, 'Squat')"))
    db_session.commit()
    
    client.post("/seances/", json={"date_seance": "2026-03-25"}, headers=auth_headers)
    s_id = client.get("/seances/", headers=auth_headers).json()[0]["id_seance"]
    
    client.post("/seance_exos/", json={"id_seance": s_id, "id_exercice": 1, "daily_1rm": 100.0, "ordre_passage": 1}, headers=auth_headers)
    exos = client.get(f"/seances/{s_id}/exos", headers=auth_headers).json()
    return exos[0]["id_seance_exo"]

def test_create_serie(client, auth_headers, seance_exo_id):
    response = client.post(
        "/series/",
        json={
            "id_seance_exo": seance_exo_id,
            "charge_kg": 80.0,
            "nombre_reps": 5,
            "numero_serie": 1
        },
        headers=auth_headers
    )
    assert response.status_code == status.HTTP_200_OK
    assert response.json()["charge_kg"] == 80.0

def test_create_repetition(client, auth_headers, seance_exo_id):
    # 1. Create serie
    ser_resp = client.post("/series/", json={"id_seance_exo": seance_exo_id, "charge_kg": 80.0, "nombre_reps": 5, "numero_serie": 1}, headers=auth_headers)
    ser_data = ser_resp.json()
    ser_id = ser_data["id"]
    
    # 2. Add repetition
    response = client.post(
        "/repetitions/",
        json={"id_serie": ser_id, "numero_rep": 1, "vitesse_mesuree": 0.5},
        headers=auth_headers
    )
    assert response.status_code == status.HTTP_200_OK
    assert response.json()["vitesse_mesuree"] == 0.5

def test_rolling_vbt_skipped(client, auth_headers):
    response = client.post(
        "/rolling_vbt",
        json={"id_exercice": 1},
        headers=auth_headers
    )
    assert response.status_code == status.HTTP_200_OK
    assert response.json()["status"] == "skipped"

def test_initialize_profile(client, auth_headers):
    # 1. First define 1RM to create the profile row (Using correct route /rm1_users/)
    client.post("/rm1_users/", json={"id_exercice": "1", "current_1rm": 100.0}, headers=auth_headers)
    
    # 2. Then initialize
    response = client.post(
        "/initialize",
        json={
            "idexercice": "1",
            "rpe_low": 6.0,
            "rpe_high": 9.0,
            "speed_low": 0.7,
            "speed_high": 0.3
        },
        headers=auth_headers
    )
    assert response.status_code == status.HTTP_200_OK
    assert "slope" in response.json()

def test_initialize_profile_not_found(client, auth_headers):
    # Try to initialize for an exercise without RM1
    response = client.post(
        "/initialize",
        json={
            "idexercice": "999",
            "rpe_low": 6.0,
            "rpe_high": 9.0,
            "speed_low": 0.7,
            "speed_high": 0.3
        },
        headers=auth_headers
    )
    assert response.status_code == status.HTTP_404_NOT_FOUND

def test_daily_1rm_saves_to_seance_exo(client, auth_headers, seance_exo_id):
    # 1. Setup profil VBT
    client.post("/rm1_users/", json={"id_exercice": "1", "current_1rm": 100.0}, headers=auth_headers)
    client.post("/initialize", json={"idexercice": "1", "rpe_low": 6.0, "rpe_high": 9.0, "speed_low": 0.7, "speed_high": 0.3}, headers=auth_headers)

    # 2. Compute daily 1RM
    response = client.post(
        "/daily_1rm/",
        json={"idexercice": "1", "id_seance_exo": seance_exo_id, "nbrep": 3, "poidsbarre": 80.0, "vitesse": 0.5},
        headers=auth_headers
    )
    assert response.status_code == status.HTTP_200_OK
    data = response.json()
    assert "rmdaily" in data
    assert data["rmdaily"] > 0

    # 3. Verify it was saved in seance_exo
    seances_resp = client.get("/seances/", headers=auth_headers).json()
    s_id = seances_resp[0]["id_seance"]
    exos = client.get(f"/seances/{s_id}/exos", headers=auth_headers).json()
    saved_daily_1rm = next(e for e in exos if e["id_seance_exo"] == seance_exo_id)["daily_1rm"]
    assert saved_daily_1rm == data["rmdaily"]


def test_compute_rpe(client, auth_headers):
    # 1. Define 1RM
    client.post("/rm1_users/", json={"id_exercice": "1", "current_1rm": 100.0}, headers=auth_headers)
    
    # 2. Initialize
    client.post("/initialize", json={"idexercice": "1", "rpe_low": 6.0, "rpe_high": 9.0, "speed_low": 0.7, "speed_high": 0.3}, headers=auth_headers)
    
    # 3. Compute
    response = client.post(
        "/compute_rpe",
        json={"idexercice": "1", "speed": 0.5},
        headers=auth_headers
    )
    assert response.status_code == status.HTTP_200_OK
    assert response.json()["rpe"] == 7.5
