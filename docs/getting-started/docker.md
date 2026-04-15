# Lancer le Projet (Docker)

Bartrack est conçu pour être facilement lancable dans un environnement isolé (conteneurs) à l'aide de Docker. C'est la méthode recommandée pour le développement local et la mise en production.

## Prérequis

- [Docker](https://docs.docker.com/get-docker/) installé sur votre machine.

## 1. Fichier d'environnement (`.env`)

Avant de lancer les conteneurs, assurez-vous de posséder un fichier `.env` à la racine de l'application contenant toutes les variables critiques.

```bash title=".env"
postgres_user=bartrack_user
postgres_password=your_secure_password
postgres_host=db
postgres_port=5432
postgres_db=bartrack_db
SECRET_KEY=your_secret_key
```

!!! info "Remarque"
    Le champ `postgres_host` doit pointer sur l'adresse de votre base de données PostgreSQL (votre container dédié ou un service distant externe).

## 2. Base de Données (PostgreSQL)

Comme nous n'utilisons pas de système unifié Docker Compose, vous devez faire tourner une instance de base de données PostgreSQL séparément. Si vous souhaitez en instancier une localement avec Docker :

```bash
docker run -d \
  --name bartrack-db \
  -e POSTGRES_USER=bartrack_user \
  -e POSTGRES_PASSWORD=your_secure_password \
  -e POSTGRES_DB=bartrack_db \
  -p 5432:5432 \
  postgres:15-alpine
```

## 3. Lancement de l'API Bartrack

Ensuite, vous pouvez construire et lancer l'image Docker contenant uniquement l'API FastAPI. 

À la racine du projet, compilez l'image :
```bash
docker build -t bartrack-api .
```

Puis démarrez le conteneur en pointant vers votre fichier `.env` :
```bash
docker run -d \
  --name bartrack-api \
  --env-file .env \
  -p 8000:8000 \
  bartrack-api
```

## 4. Accès à l'application

Une fois les logs stabilisés, vous pouvez interagir avec l'application web auto-hébergée côté utilisateur :

- **Swagger UI (Tests interactifs)** : `http://localhost:8000/docs`
- **ReDoc** : `http://localhost:8000/redoc`

Pour éteindre l'API :
```bash
docker stop bartrack-api
```
