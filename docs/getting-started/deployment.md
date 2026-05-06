# CI/CD & Déploiement

Bartrack est livré avec un pipeline d'automatisation complet via **GitHub Actions**. L'objectif : zéro friction entre un `git push` et un environnement de production à jour — documentation incluse.

---

## Pipeline 1 — Mise à jour automatique de la documentation

**Déclencheur :** chaque `push` sur la branche `main`.

Ce pipeline prend en charge la génération et la publication de toute la documentation de Bartrack sur **GitHub Pages** — sans aucune intervention manuelle de ta part.

**Ce qu'il fait, étape par étape :**

1. Récupère le code source complet depuis le dépôt.
2. Configure un environnement Python et installe les dépendances (`MkDocs Material`, `mkdocstrings`, `Pillow`, `cairosvg`).
3. Parse automatiquement toutes les docstrings Python du projet pour générer les pages de référence API.
4. Construit un site statique optimisé depuis les fichiers Markdown.
5. Le pousse sur la branche orpheline `gh-pages`, hébergée gratuitement par GitHub.

!!! tip "Documentation toujours à jour"
    Grâce à ce pipeline, la documentation que tu lis en ce moment a été générée automatiquement à partir du code. Quand un service est modifié ou qu'une docstring est ajoutée, la doc se met à jour toute seule au prochain push.

---

## Pipeline 2 — Déploiement sur le VPS

C'est ici que l'automatisation prend tout son sens en production. Dès qu'un push stable arrive sur `main`, le VPS se met à jour sans que personne n'ait à s'y connecter manuellement.

**Le processus complet :**

1. L'action GitHub s'authentifie sur le VPS via une clé SSH stockée de façon sécurisée dans les *Secrets* du dépôt.
2. Sur le VPS, un `git pull origin main` rapatrie la dernière version du code.
3. L'ancienne image Docker est stoppée et supprimée proprement.
4. Une nouvelle image est compilée à partir du code frais et relancée immédiatement.

```bash
docker build -t bartrack-api .
docker stop bartrack-api || true
docker rm bartrack-api || true
docker run -d --name bartrack-api --env-file .env -p 8000:8000 bartrack-api
```

5. La base de données PostgreSQL n'est jamais touchée — seul le conteneur API est remplacé.

**Résultat :** de ton éditeur de code à la production, le cycle complet prend moins de deux minutes.

!!! danger "Ne jamais versionner tes secrets"
    Les informations sensibles (IP du serveur, clé SSH, mots de passe) ne doivent **jamais** apparaître en clair dans les fichiers `.github/workflows/`. Utilise exclusivement les **GitHub Secrets** (`Settings → Secrets and variables → Actions`) pour stocker :

    - `SSH_PRIVATE_KEY` — ta clé privée SSH pour accéder au VPS
    - `HOST_IP` — l'adresse IP de ton serveur
    - `VPS_USER` — l'utilisateur SSH cible

    Ces valeurs sont injectées à l'exécution et ne sont jamais exposées dans les logs.
