# Services de Calculs (Aperçu)

Le service `calculations` est le coeur mathématique de tout le système Bartrack. Contrairement aux services basiques qui gèrent la base de données (tels que les utilisateurs ou programmes), ce service est chargé de toutes les transformations des signaux en mesures concrètes.

Pour alléger la documentation, et structurer cet ensemble d'algorithmes complexes, ce service a été segmenté fonctionnellement dans les sous-rubriques de gauche :

- **Algorithmes VBT** : Contient le requêtage de base pour les regressions linéaires glissantes, le `slope` et la configuration originelle de l'athlète.
- **RPE & 1RM** : Contient les recommandations en temps réel permettant l'Auto-régulation.
