# Architecture Docker de Bartrack

Bartrack est conçu pour fonctionner dans des conteneurs Docker isolés. Cette approche permet d'encapsuler l'environnement complet de l'application (Python, dépendances, API FastAPI) et la base de données PostgreSQL sans nécessiter d'installation manuelle sur la machine hôte.

---

## Configuration requise

L'application nécessite [Docker Desktop](https://docs.docker.com/get-docker/) pour gérer l'orchestration des conteneurs en local ou sur un serveur.

---

## Variables d'environnement

Le projet utilise un fichier `.env` à la racine pour centraliser toutes les variables de configuration sensibles. Ce fichier contient les paramètres de connexion à PostgreSQL et la clé secrète pour la signature des tokens JWT.

```bash title=".env"
postgres_user=bartrack_user
postgres_password=ton_mot_de_passe_securise
postgres_host=db
postgres_port=5432
postgres_db=bartrack_db
SECRET_KEY=une_cle_secrete_longue_et_aleatoire
```

!!! info "À propos de `postgres_host`"
    En développement local avec Docker, `postgres_host` correspond au nom du conteneur de la base de données (typiquement `db` avec Docker Compose). En production sur un VPS, il s'agit de l'IP ou du domaine du serveur PostgreSQL.

---

## Conteneur PostgreSQL

L'application s'appuie sur **PostgreSQL 15** comme système de gestion de base de données. Un conteneur dédié peut être lancé avec la commande suivante :

```bash
docker run -d \
  --name bartrack-db \
  -e POSTGRES_USER=bartrack_user \
  -e POSTGRES_PASSWORD=ton_mot_de_passe_securise \
  -e POSTGRES_DB=bartrack_db \
  -p 5432:5432 \
  postgres:15-alpine
```

Cette configuration démarre le conteneur en arrière-plan (`-d`) et expose PostgreSQL sur le port standard `5432`.

---

## Conteneur API

L'API FastAPI est compilée sous forme d'image Docker à partir du `Dockerfile` situé à la racine du projet :

```bash
docker build -t bartrack-api .
```

Le conteneur API est ensuite démarré en chargeant les variables d'environnement depuis le fichier `.env` :

```bash
docker run -d \
  --name bartrack-api \
  --env-file .env \
  -p 8000:8000 \
  bartrack-api
```

Les logs de démarrage peuvent être consultés via :

```bash
docker logs bartrack-api
```

---

## Interfaces de documentation

Une fois l'API opérationnelle, deux interfaces de documentation interactive sont accessibles :

| Interface | URL | Description |
|---|---|---|
| **Swagger UI** | `http://localhost:8000/docs` | Tests interactifs de toutes les routes |
| **ReDoc** | `http://localhost:8000/redoc` | Documentation lisible et structurée |

---

## Gestion des conteneurs

Voici les principales commandes Docker utilisées pour gérer l'environnement Bartrack :

```bash
# Arrêter le conteneur API
docker stop bartrack-api

# Reconstruire l'image et redémarrer le conteneur
docker build -t bartrack-api . && docker restart bartrack-api

# Consulter les logs en temps réel
docker logs -f bartrack-api
```

!!! tip "Mode développement"
    En environnement de développement, il est possible de monter le code source en volume (`-v $(pwd)/api:/app/api`) pour éviter de reconstruire l'image à chaque modification. Associé au flag `--reload` d'Uvicorn, cela permet à FastAPI de recharger automatiquement les changements.
