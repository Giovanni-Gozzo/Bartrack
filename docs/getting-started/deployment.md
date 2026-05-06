# Automatisation CI/CD

Bartrack intègre une chaîne d'automatisation complète via **GitHub Actions** qui gère à la fois la génération de documentation et le déploiement en production. Chaque `push` sur la branche `main` déclenche automatiquement ces pipelines.

---

## Pipeline de documentation

**Déclenchement :** automatique à chaque `push` sur `main`.

Ce workflow assure la génération et la publication de l'ensemble de la documentation technique sur **GitHub Pages**, incluant les docstrings Python parsées depuis le code source.

**Fonctionnement du workflow :**

1. Récupération du code source complet depuis le dépôt Git.
2. Configuration d'un environnement Python avec installation des dépendances documentation (`MkDocs Material`, `mkdocstrings`, `Pillow`, `cairosvg`).
3. Parsing automatique des docstrings Python pour générer les pages de référence API.
4. Construction d'un site statique optimisé à partir des fichiers Markdown.
5. Publication sur la branche orpheline `gh-pages`, hébergée gratuitement via GitHub Pages.

!!! tip "Documentation synchronisée"
    Ce système garantit que la documentation reste toujours alignée avec le code source. Toute modification de service ou ajout de docstring est automatiquement reflété dans la documentation après chaque push.

---

## Pipeline de déploiement production

**Déclenchement :** automatique à chaque `push` sur `main`.

Ce workflow orchestre le déploiement automatisé sur le VPS de production via SSH, permettant une mise à jour de l'application sans intervention manuelle.

**Déroulement du processus :**

1. Authentification SSH sur le VPS via une clé privée stockée de façon sécurisée dans les *Secrets* GitHub.
2. Récupération de la dernière version du code via `git pull origin main` sur le serveur.
3. Arrêt et suppression de l'ancien conteneur Docker API.
4. Compilation d'une nouvelle image Docker depuis le code mis à jour et démarrage immédiat du nouveau conteneur.

```bash
docker build -t bartrack-api .
docker stop bartrack-api || true
docker rm bartrack-api || true
docker run -d --name bartrack-api --env-file .env -p 8000:8000 bartrack-api
```

5. La base de données PostgreSQL reste intacte durant tout le processus, seul le conteneur API est remplacé.

Le cycle complet, de la validation du code à la mise en production, s'exécute en moins de deux minutes.

!!! danger "Gestion des secrets"
    Les informations sensibles (IP du serveur, clé SSH, mots de passe) sont stockées exclusivement dans les **GitHub Secrets** (`Settings → Secrets and variables → Actions`) et ne doivent jamais apparaître en clair dans les fichiers de workflow. Les secrets utilisés par le pipeline de déploiement sont :

    - `SSH_PRIVATE_KEY` : clé privée SSH pour l'authentification sur le VPS
    - `HOST_IP` : adresse IP du serveur de production
    - `VPS_USER` : nom d'utilisateur SSH sur le serveur cible

    Ces valeurs sont injectées à l'exécution et ne sont jamais exposées dans les logs GitHub Actions.
