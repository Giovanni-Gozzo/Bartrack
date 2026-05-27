---
hide:
  - navigation
  - toc
---

<div class="home-page" markdown>

<div style="text-align: center" markdown>

<p align="center">
  <img src="bartrack.png" alt="Bartrack Logo" width="260" class="hero-logo"/>
</p>

# Bienvenue sur Bartrack

**Bartrack** est une application pensée pour les athlètes de force qui veulent aller au-delà du simple carnet d'entraînement. En s'appuyant sur le **VBT** (*Velocity Based Training*), elle transforme les données de vitesse barre en temps réel en recommandations concrètes, charge optimale, RPE réel, évolution du 1RM.

Plus de devinettes. Plus de sur-entraînement par hasard. Juste de la donnée exploitable, séance après séance.

---

<div class="grid cards" markdown>

-   :material-rocket-launch: **Démarrer en 5 minutes**

    Tout ce qu'il faut pour faire tourner Bartrack localement via environnement Docker, base de données, API.

    [Lancer le projet](getting-started/docker.md){ .md-button .md-button--primary }

-   :material-map-marker-path: **Comment ça fonctionne ?**

    Du premier squat au profil VBT affiné : découvrez le parcours complet d'un athlète dans Bartrack.

    [Voir le workflow](workflow.md){ .md-button }

-   :material-api: **Référence API complète**

    Chaque service, chaque algorithme, chaque route documentée directement depuis le code source.

    [Explorer l'API](api/main.md){ .md-button }

</div>

---

## Ce que Bartrack fait pour toi

| Fonctionnalité | Description |
|---|---|
| **Suivi VBT** | Calcul du RPE et du 1RM à partir de la vitesse finale de chaque série |
| **Régression linéaire** | Profil *slope/intercept* mis à jour au fil des séances via rolling VBT |
| **Programmes** | Création de blocs d'entraînement complets avec charge cible et RPE prévu |
| **Temps réel** | Feedback instantané après chaque série via les endpoints `/compute_rpe` et `/compute_weight` |
| **Auth JWT** | Chaque athlète dispose de son profil isolé et sécurisé |

</div>

</div>
