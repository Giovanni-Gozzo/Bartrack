async def calculate_daily_1rm(payload: schemas.Daily1rmRequest, db: Session, user_email: str):
    # 1. Fetch User
    user = await users.get_user_by_email(user_email, db)
    user_id = int(user["id_utilisateur"])

    # 2. Récupérer le 1RM Actuel (Historique)
    RM1 = 0.0
    try:
        req = schemas.GenericQueryRequest(
            table_name="profil_vbt",
            columns=["current_1rm"],
            conditions={"id_utilisateur": user_id, "id_exercice": int(payload.idexercice)}
        )
        data = await query.execute_generic_query(req, db)
        if data:
            RM1 = float(data[0]["current_1rm"])
    except Exception as e:
        print(f"Erreur recup 1RM: {e}")
        return {"error": "Impossible de récupérer le 1RM"}

    # 3. Calcul du RPE Réel (Via Vitesse)
    # On délègue à ta fonction existante
    payload_rpe = schemas.ComputeRpeRequest(
        idexercice=payload.idexercice,
        speed=payload.vitesse
    )
    rpe_result = await calculate_rpe(payload_rpe, db, user_email)
    rpe_reel_brut = float(rpe_result["rpe"])
    
    # 4. Arrondi du RPE Réel pour matcher la Table de Référence
    # On arrondit au 0.5 le plus proche (ex: 8.2 -> 8.0, 8.4 -> 8.5)
    rpe_reel_rounded = round(rpe_reel_brut * 2) / 2
    # Sécurité : On borne entre 6.5 et 10 (limites usuelles du tableau)
    rpe_reel_rounded = max(6.5, min(10.0, rpe_reel_rounded))

    # 5. Récupérer le Pourcentage correspondant à ce RPE/Reps RÉEL
    # On cherche : "A 3 reps pour RPE 8.5 (réel), ça vaut combien de % ?"
    pourcentage_reel = 0.0
    try:
        req = schemas.GenericQueryRequest(
            table_name="ref_rpe_table",
            columns=["percentage"],
            conditions={
                "rpe": rpe_reel_rounded,
                "reps": payload.nbrep
            }
        )
        data = await query.execute_generic_query(req, db)
        if data:
            pourcentage_reel = float(data[0]["percentage"])
    except Exception as e:
        print(f"Erreur recup pourcentage: {e}")

    # 6. Calcul du Daily 1RM (La règle de trois)
    # Si j'ai soulevé 90kg et que ça valait 89% (RPE 9), alors 100% = 90 / 0.89
    rm_daily = RM1 # Par défaut
    
    if pourcentage_reel > 0:
        rm_daily = payload.poidsbarre / pourcentage_reel

    # 7. Comparaison pour le feedback (Optionnel mais cool pour le front)
    # On calcule l'écart en %
    variation = ((rm_daily - RM1) / RM1) * 100

    return {
        "rmdaily": round(rm_daily, 2),
        "rm_historique": RM1,
        "variation_percent": round(variation, 1),
        "debug": {
            "rpe_reel_mesure": rpe_reel_brut,
            "rpe_reel_arrondi": rpe_reel_rounded,
            "pourcentage_utilise": pourcentage_reel
        }
    }
