<div align="center">
  <img src="bartrack.png" alt="Bartrack Banner" height="125">
</div>

# Bartrack API

Bartrack est conçue pour la gestion et le suivi des entraînements de musculation et de force, avec un accent particulier sur le **VBT (Velocity Based Training)**. 

L'API permet de suivre des utilisateurs, de gérer un catalogue d'exercices, d'organiser des séances d'entraînement (exercices, séries, répétitions) et fournit de nombreux endpoints pour calculer automatiquement les charges, RPE (Rate of Perceived Exertion), 1RM (1 Répétition Maximale) et profils Force-Vitesse personnalisés.

L'API est construite en Python avec le framework **FastAPI** et utilise une base de données relationnelle **PostgresSQL** via **SQLAlchemy**.

---

## Déroulé typique de l'application

Voici le parcours classique de la donnée et des actions qu'un utilisateur réalise à travers l'API :

### 1. Authentification & Utilisateur
Avant de commencer, l'utilisateur doit disposer d'un compte.
- **`POST /users/`** : L'utilisateur crée son compte avec ses informations.
- **`POST /login`** : L'utilisateur se connecte avec son email (`username`) et son mot de passe pour récupérer son token JWT (l'API est sécurisée de bout en bout).
- **`GET/PUT /users/me`** : L'utilisateur consulte ou met à jour son profil (poids de corps, préférences, etc.).

### 2. Base de connaissances & Initialisation
L'utilisateur a besoin d'exercices pour s'entraîner et d'un profil VBT initial.
- **`GET /exercices/`** : L'utilisateur récupère la liste des exercices disponibles. (Les administrateurs peuvent interagir via `POST/PUT/DELETE /exercices/`).
- **`POST /profil_vbt/`** : Pour un exercice donné, l'utilisateur peut paramétrer son profil et enregistrer son 1RM. 
- **`POST /initialize`** : Le système initialise le profil de l'utilisateur à partir d'un RPE haut/bas et de vitesses associées.

### 3. Création et déroulement d'une Séance
Le jour de l'entraînement, l'utilisateur enregistre sa séance étape par étape :
- **`POST /seances/`** : L'utilisateur initialise la séance du jour.
- **`POST /seance_exos/`** : Il ajoute un ou plusieurs exercices spécifiques à sa séance (ex: Squat, Développé Couché).
- **`POST /series/`** : Pour l'exercice en cours, l'utilisateur indique qu'il commence une série (objectif, charge prévue).
- **`POST /repetitions/`** : À chaque répétition le système embarqué enregistre la vitesse et le tout est envoyé.

### 4. Outils de Calcul en Temps Réel
Pendant la séance, l'application peut assister l'utilisateur pour calibrer ses charges (Autorégulation) de plusieurs manières :
- **`POST /compute_rpe`** : Basé sur la vitesse de levé d'une barre de chauffe, l'API renvoie le RPE estimé via le profil.
- **`POST /daily_1rm/`** : Estime la force maximale de l'utilisateur (1RM) *ce jour-là* en observant les vitesses lors de l'échauffement.
- **`POST /compute_weight`** : À partir du 1RM du jour et du RPE ciblé, suggère le poids exact à mettre sur la barre.

### 5. Suivi & Mises à jour
Avec le temps, le profil de l'athlète évolue :
- **`POST /rolling_vbt`** : Recalcule le profil VBT de l'utilisateur sur une fenêtre glissante (30 derniers jours) pour que les calculs futurs soient adaptés à sa forme réelle.

---

## Architecture des Routes (Endpoints)

| Catégorie | Routes Principales | Description |
|-----------|---------------------|-------------|
| **Core** | `GET /` | Statut de l'API. |
| **Utilisateurs** | `/users/`, `/users/me` | Actions de CRUD pour les utilisateurs et gestion du profil. |
| **Authentification**| `/login` | Récupération du token OAuth2. |
| **Calculs (VBT)** | `/initialize`, `/compute_rpe`, `/compute_weight`, `/rm1_users/`, `/daily_1rm/`, `/rolling_vbt` | Cœur scientifique de l'application : équations VBT, calcul de charge, RPE et 1RM. |
| **Exercices** | `/exercices/` | Dictionnaire des exercices. |
| **Séances** | `/seances/` | Dossiers de séances d'entraînement propres à un utilisateur. |
| **Séance Exos** | `/seances/{id}/exos`, `/seance_exos/` | Rattachement des exercices aux séances. |
| **Séries** | `/seance_exos/{id}/series`, `/series/` | Listes de séries au sein de l'exercice. |
| **Répétitions** | `/series/{id}/repetitions`, `/repetitions/` | Répétitions au sein d'une série avec l'historique précis de vitesse. |
| **Profils VBT** | `/profil_vbt/` | Relation (id_utilisateur, id_exercice) qui définit le profil VBT. |
| **Generic DB** | `/generic_query`, `/generic_update`, `/generic_create` | Routes "outils" permettant du requêtage brut ou des mises à jour directes en base (Usage Admin/Root). |

---

## Données Techniques
- **API Framework** : FastAPI (Python)
- **Base de données** : Gérée via SQLAlchemy (ORM).
- **Serveur WSGI/ASGI** : Uvicorn.
- **Déploiement** : L'API est prête à être dockerisée (`Dockerfile`, `.dockerignore`).

---

## Arborescence du Projet

```text
Bartrack/
├── .dockerignore
├── .gitignore
├── Dockerfile              # Configuration pour la conteneurisation
├── README.md               # Documentation du projet
├── requirements.txt        # Dépendances du projet Python
└── api/                    # Code source principal de l'API
    ├── auth.py             # Logique d'authentification (JWT, permissions)
    ├── database.py         # Configuration de la base de données SQLAlchemy
    ├── main.py             # Point d'entrée de l'application et définition de toutes les routes
    ├── models.py           # Modèles SQLAlchemy (schémas des tables en base)
    ├── schemas.py          # Modèles Pydantic (validation des données d'entrée/sortie)
    └── services/           # Implémentation de la logique métier (CRUD et calculs)
        ├── calculations.py # Logique des calculs (RPE, 1RM, VBT...)
        ├── exercices.py
        ├── profil_vbt.py
        ├── query.py        # Fonctions de requêtes de base de données génériques
        ├── repetitions.py
        ├── seance_exos.py
        ├── seances.py
        ├── series.py
        └── users.py
```

---

## CI/CD

Bartrack dispose d'une chaîne GitHub Actions automatisée sur chaque `push` et `pull request` vers `main`.

| Étape | Outil | Critère |
|-------|-------|---------|
| Analyse statique | Pylint | Score ≥ 7.0 / 10 |
| Tests automatisés | Pytest | 28 tests passants (SQLite, sans dépendance réseau) |
| Déploiement | Coolify webhook | Déclenché uniquement si lint + tests passent |

Le déploiement en production ne s'exécute jamais si le lint ou les tests échouent.

---

## Comment lancer l'API

1. **Construire l'image Docker** :
   ```bash
   docker build -t bartrack-api .
   ```
2. **Lancer le conteneur** :
   ```bash
   docker run -d -p 8001:8001 --name bartrack-api-container bartrack-api
   ```
