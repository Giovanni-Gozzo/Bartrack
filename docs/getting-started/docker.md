# Lancer le projet avec Docker

Bartrack est packagé pour tourner dans des conteneurs isolés dès le départ. Pas besoin d'installer Python, de gérer des environnements virtuels ou de configurer PostgreSQL à la main sur ta machine — Docker s'occupe de tout.

---

## Prérequis

- [Docker Desktop](https://docs.docker.com/get-docker/) installé et en cours d'exécution.

---

## Étape 1 — Créer le fichier d'environnement

Avant de lancer quoi que ce soit, crée un fichier `.env` à la racine du projet. C'est lui qui contient toutes les variables sensibles que Bartrack utilise pour se connecter à la base de données et signer les tokens JWT.

```bash title=".env"
postgres_user=bartrack_user
postgres_password=ton_mot_de_passe_securise
postgres_host=db
postgres_port=5432
postgres_db=bartrack_db
SECRET_KEY=une_cle_secrete_longue_et_aleatoire
```

!!! info "À propos de `postgres_host`"
    En développement local avec Docker, `postgres_host` doit correspondre au nom du conteneur de ta base de données (ici `db` si tu utilises Docker Compose, ou le nom que tu lui donnes manuellement). En production sur un VPS, c'est l'IP ou le domaine de ton serveur PostgreSQL.

---

## Étape 2 — Lancer PostgreSQL

Bartrack utilise **PostgreSQL 15** comme base de données. Si tu n'en as pas déjà une qui tourne, lance un conteneur dédié en une commande :

```bash
docker run -d \
  --name bartrack-db \
  -e POSTGRES_USER=bartrack_user \
  -e POSTGRES_PASSWORD=ton_mot_de_passe_securise \
  -e POSTGRES_DB=bartrack_db \
  -p 5432:5432 \
  postgres:15-alpine
```

Le conteneur démarre en arrière-plan (`-d`) et expose PostgreSQL sur le port standard `5432`.

---

## Étape 3 — Construire et lancer l'API

À la racine du projet, compile l'image Docker de l'API :

```bash
docker build -t bartrack-api .
```

Puis démarre le conteneur en lui passant ton fichier `.env` :

```bash
docker run -d \
  --name bartrack-api \
  --env-file .env \
  -p 8000:8000 \
  bartrack-api
```

Attends quelques secondes le temps que FastAPI démarre, puis vérifie les logs :

```bash
docker logs bartrack-api
```

---

## Étape 4 — Accéder à l'application

Une fois l'API démarrée, deux interfaces sont disponibles directement dans ton navigateur :

| Interface | URL | Description |
|---|---|---|
| **Swagger UI** | `http://localhost:8000/docs` | Tests interactifs de toutes les routes |
| **ReDoc** | `http://localhost:8000/redoc` | Documentation lisible et structurée |

---

## Commandes utiles

```bash
# Arrêter l'API
docker stop bartrack-api

# Redémarrer après une modification de code
docker build -t bartrack-api . && docker restart bartrack-api

# Voir les logs en temps réel
docker logs -f bartrack-api
```

!!! tip "Astuce de dev"
    Pour itérer rapidement sans reconstruire l'image à chaque changement, tu peux monter le code source en volume : `-v $(pwd)/api:/app/api`. FastAPI rechargera automatiquement si tu utilises `--reload` dans la commande de démarrage Uvicorn.
