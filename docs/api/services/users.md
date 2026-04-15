# Gestion des Utilisateurs et Authentification

Cette section détaille les services permettant de gérer le cycle de vie des utilisateurs de Bartrack, de l'inscription à la récupération de données et à l'authentification (Tokens).

## Récupération de Données

Ces fonctions sont optimisées pour la lecture et ne modifient pas le profil global de la base de données de manière structurante.

::: api.services.users.get_user_by_email
    options:
      show_root_heading: true
      heading_level: 3

::: api.services.users.get_current_user_profile
    options:
      show_root_heading: true
      heading_level: 3

::: api.services.users.authenticate_user
    options:
      show_root_heading: true
      heading_level: 3

## Actions de Modification

!!! warning "Attention aux effets de bord"
    Ces fonctions modifient directement la base de données utilisateurs ou insèrent de nouvelles lignes qui nécessitent une forte intégrité (Ex: création du profil, mise à jour du 1RM référent). Assurez-vous de valider les données en amont de ces requêtes.

::: api.services.users.register_new_user
    options:
      show_root_heading: true
      heading_level: 3

::: api.services.users.update_user_profile
    options:
      show_root_heading: true
      heading_level: 3

::: api.services.users.rm1_users
    options:
      show_root_heading: true
      heading_level: 3
