### 1. Ce que j’ai fait concrètement
**→ Valider la réalisation des tâches dans le temps**

Dans le cadre de notre projet, j'ai mené à bien plusieurs tâches techniques de manière autonome et collaborative. En autonomie, j'ai entièrement pris en charge la **partie tests** (mise en place de tests unitaires et asynchrones avec `pytest` et `pytest-asyncio`) pour assurer la robustesse de notre application. J'ai également développé l'ensemble des **routes de l'API nécessaires au fonctionnement classique du site** (en utilisant `FastAPI` et `Pydantic` pour la validation), à l'exclusion des routes de "computing".

En parallèle, j'ai travaillé en binôme sur les fondations techniques du projet : nous avons réalisé ensemble la **recherche métier sur l'altérophilie**, élaboré le **MCD (Modèle Conceptuel de Données)** et mis en place toute la **base de données** (via `SQLAlchemy` et `PostgreSQL` / `Supabase`). Enfin, le développement des **routes "computing"**, impliquant la logique de traitement de données (avec des outils comme `pandas`, `numpy` ou `scikit-learn`), a lui aussi été co-développé à deux.

### 2. Où j’en suis
**→ Vision d’avancement**

À ce stade, ma progression est parfaitement alignée avec les objectifs fixés. Les fondations de l'application sont solides : la base de données relationnelle est modélisée et fonctionnelle, et les routes principales de notre API FastAPI sont opérationnelles et couvertes par mes tests automatisés. L'intégration de la logique métier (routes computing) ayant été amorcée en binôme, je suis maintenant dans une phase où mes développements backend sont robustes et prêts à être pleinement exploités par le front-end du site.

### 3. Ce que j'ai fait qui a aidé l’équipe
**→ Collaboration et montée en compétence**

Mon choix de réaliser la recherche sur l'altérophilie, la modélisation sous `SQLAlchemy` et l'architecture de la base de données en binôme a été très bénéfique. Cela a permis de s'assurer que nous partagions tous la même compréhension des règles métiers et des schémas de données avant de coder. De plus, le fait d'avoir développé les "routes computing" ensemble (pair programming sur les scripts de traitement de données) a favorisé le croisement de nos compétences (ingénierie des données vs développement web) et garanti une meilleure cohérence entre les algorithmes de calcul et l'API web que je construisais.

### 4. Un problème identifié
**→ Capacité d’alerte**

Au cours de la séparation des tâches (routes FastAPI classiques d'un côté, logique data/computing de l'autre), j'ai pu identifier un risque lié à la communication entre nos différentes briques. Avec des règles métiers complexes liées à l'altérophilie et des traitements lourds, il y a un fort risque de désynchronisation entre les schémas de données attendus par le site (mes modèles `Pydantic`) et les résultats renvoyés par les algorithmes. Sans un suivi rigoureux des structures de données, cela pourrait bloquer l'intégration entre le back-end et le front-end.

### 5. Ma proposition pour améliorer
**→ Force de proposition + régulation**

Pour prévenir ce problème, je propose de nous appuyer sur notre documentation d'API (actuellement en cours de réalisation par Julien Castellano via `MkDocs` et `mkdocstrings`) pour en faire un véritable "contrat d'interface" strict et partagé par toute l'équipe. De plus, nous pourrions instaurer des points de synchronisation techniques très courts (10-15 min) ciblant spécifiquement la validation des échanges de données entre les routes du site et les routes computing. Cela permettra de s'assurer que chaque développeur sait exactement quels objets JSON envoyer et recevoir, fluidifiant ainsi la fin du projet.