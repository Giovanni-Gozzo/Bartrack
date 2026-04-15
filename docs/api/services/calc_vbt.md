# Algorithmes du Profil VBT

Le moteur Velocity Based Training de Bartrack repose sur la modélisation mathématique du profil "Vitesse-Charge" (`slope` et `intercept`). 

## Initialisation

Lorsqu'un utilisateur vient pour la première fois, il doit calibrer son profil via l'association de l'API avec ses vitesses réelles mesurées ou estimées.

::: api.services.calculations.initialize_profile
    options:
      show_root_heading: true
      heading_level: 3

## Rolling VBT Algorithm

Cet algorithme tourne pour adapter dynamiquement la courbe de force de l'athlète de manière continue, grâce à une `Linear Regression` calculée sur ses dernières séries accumulées.

!!! info "Algorithme glissant"
    Cet algorithme re-calcule les stats de l'athlète en fonction de ses séries les plus récentes, généralement sur une période glissante de 30 jours, ignorant les performances passées obsolètes.

::: api.services.calculations.compute_rolling_vbt_profile
    options:
      show_root_heading: true
      heading_level: 3
