# Automatisation CI/CD

Bartrack intègre une chaîne d'automatisation complète via **GitHub Actions** qui gère la qualité du code, les tests, la génération de documentation et le déploiement en production. Chaque `push` sur la branche `main` déclenche automatiquement ces pipelines.

---

## Pipeline de qualité & tests (CI)

**Déclenchement :** à chaque `push` et `pull request` sur `main`.

Ce workflow garantit que le code fusionné est propre, testé et respecte les standards de qualité avant tout déploiement.

**Étapes du workflow :**

1. Récupération du code source depuis le dépôt.
2. Installation des dépendances Python (`requirements.txt`).
3. **Analyse statique avec Pylint** — le code est inspecté et doit obtenir un score minimum de **7.0 / 10**. Les règles activées couvrent les erreurs logiques, les imports inutilisés, les mauvaises pratiques (`raise` sans `from`, comparaisons incorrectes, etc.).
4. **Exécution de la suite de tests avec Pytest** — les 28 tests unitaires et d'intégration sont lancés sur une base SQLite en mémoire, sans dépendance à la base de production.

```yaml
- name: Lint with pylint
  run: pylint api/ --fail-under=7.0

- name: Run tests
  run: pytest tests/ -v
```

Le déploiement ne se déclenche **que si cette étape réussit entièrement**.

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

**Déclenchement :** automatique à chaque `push` sur `main`, uniquement si le pipeline CI passe entièrement.

Le déploiement est géré par **Coolify**, qui prend en charge la reconstruction de l'image Docker et le redémarrage du conteneur. GitHub Actions se contente de déclencher ce processus via un appel webhook.

**Déroulement du processus :**

1. Le pipeline CI (lint + tests) s'exécute et doit réussir.
2. GitHub Actions envoie une requête au webhook Coolify.
3. Coolify reconstruit l'image Docker depuis le code à jour et redémarre le conteneur automatiquement.
4. La base de données PostgreSQL reste intacte durant tout le processus.

```yaml
- name: Trigger Coolify deployment
  if: ${{ secrets.COOLIFY_WEBHOOK_URL != '' }}
  run: |
    curl -X GET "${{ secrets.COOLIFY_WEBHOOK_URL }}" \
      -H "Authorization: Bearer ${{ secrets.COOLIFY_WEBHOOK_SECRET }}"
```

!!! danger "Gestion des secrets"
    Les secrets suivants doivent être configurés dans `Settings → Secrets and variables → Actions` :

    - `COOLIFY_WEBHOOK_URL` : URL du webhook fournie par Coolify
    - `COOLIFY_WEBHOOK_SECRET` : token d'authentification associé

    Si ces secrets sont absents, l'étape de déploiement est automatiquement ignorée sans faire échouer le pipeline.
