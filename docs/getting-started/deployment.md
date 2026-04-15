# CI/CD et Déploiement

Cette application adopte des pratiques d'intégration et de livraison continues (CI/CD) gérées via **GitHub Actions**. Ces pipelines garantissent la mise à jour pérenne du projet sans friction.

## 1. Déploiement de la Documentation (`docs.yml`)

Ce pipeline se déclenche automatiquement à chaque `push` sur la branche `main`.

**Ce qu'il fait :**

- Checkout du code source complet.
- Mise en place d'un environnement Python avec installation des dépendances (`MkDocs-Material`, `Mkdocstrings`, `Pillow`...).
- Génération d'un site web statique depuis les fichiers Markdown et le parse des Docstrings Python.
- Pousse ce site sur la branche orpheline `gh-pages` hébergée gratuitement et automatiquement par l'infrastructure GitHub.

!!! tip "Disponibilité"
    C'est ce qui nous permet de propulser la documentation actuelle en direct, avec zéro temps de maintenance !

## 2. Déploiement sur le VPS

La véritable force de notre automatisation réside dans la pipeline de production vers le serveur distant (VPS).
Lorsqu'un code `push` vers `main` est avéré stable :

1. L'action GitHub se connecte en SSH au VPS grâce à un jeu de clés enregistré dans la configuration GitHub (`Secrets`).
2. Sur le VPS, le script lance un `git pull origin main` pour rapatrier la dernière version de Bartrack.
3. Le serveur va ensuite recompiler et redémarrer l'image Docker de l'API avec des commandes natives :
   ```bash
   docker build -t bartrack-api .
   docker stop bartrack-api || true
   docker rm bartrack-api || true
   docker run -d --name bartrack-api --env-file .env -p 8000:8000 bartrack-api
   ```
4. Les bases de données isolées ne sont jamais altérées. Le backend FastAPI, lui, est immédiatement mis à jour et bascule sur le code frais.

!!! danger "Gestion des Secrets"
    Ne codez jamais vos adresses d'hôtes IP ou vos clés SSH en clair dans `.github/workflows/deploy_vps.yml`. Utilisez toujours les variables `SSH_PRIVATE_KEY`, `HOST_IP` et `USER` depuis le coffre-fort de GitHub.
