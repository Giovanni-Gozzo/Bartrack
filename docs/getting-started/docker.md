# Lancer le Projet (Docker)

Bartrack est conçu pour être facilement lancable dans un environnement isolé (conteneurs) à l'aide de Docker et Docker Compose. C'est la méthode recommandée pour le développement local et la mise en production.

## Prérequis

- [Docker](https://docs.docker.com/get-docker/) installé sur votre machine.
- [Docker Compose](https://docs.docker.com/compose/install/) activé.

## 1. Fichier d'environnement (`.env`)

Avant de lancer les conteneurs, assurez-vous de posséder un fichier `.env` à la racine de l'application contenant toutes les variables critiques.

```bash title=".env"
postgres_user=bartrack_user
postgres_password=your_secure_password
postgres_host=db
postgres_port=5432
postgres_db=bartrack_db
SECRET_KEY=your_super_secret_jwt_key
```

!!! info "Remarque"
    Le champ `postgres_host` doit pointer sur le nom du conteneur de la base de données (ex: `db` dans Docker Compose) et non pas sur `localhost`.

## 2. Lancement des Services

À la racine du projet, exécutez la commande suivante pour construire et démarrer les conteneurs en tâche de fond :

```bash
docker-compose up -d --build
```

Cette commande orchestrera plusieurs choses :
1. **Base de Données PostgreSQL** : Initie un volume persistant et prépare les tables.
2. **API Backend (FastAPI)** : Expose l'application sur le port configuré (typiquement `8000`).

## 3. Accès à l'application

Une fois les logs stabilisés, vous pouvez interagir avec l'application :
- **Swagger UI (Tests interactifs)** : `http://localhost:8000/docs`
- **ReDoc** : `http://localhost:8000/redoc`

Pour éteindre proprement les serveurs locaux :
```bash
docker-compose down
```
