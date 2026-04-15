# Algorithmes RPE et 1RM

Ces algorithmes ne mettent pas à jour le profil global `slope/intercept` de l'athlète, mais effectuent des recommandations ou des dérivées mathématiques instantanées au cours d'une séance précise (RPE, Charge Estimée).

## Modèle d'Autorégulation Temporelle

Le VBT s'utilise aussi pour ajuster sa séance d'entraînement *en direct* en recommandant au sportif de monter ou descendre ses poids :

::: api.services.calculations.calculate_weight
    options:
      show_root_heading: true
      heading_level: 3

::: api.services.calculations.calculate_rpe
    options:
      show_root_heading: true
      heading_level: 3

## L'Estimation du 1RM quotidien

Chaque jour, à cause de la fatigue nerveuse ou musculaire, le 1 Repetition Max de l'athlète varie de ± 5 à 18%. Cet algorithme détecte ce "Daily 1RM" en s'appuyant sur l'échauffement.

::: api.services.calculations.calculate_daily_1rm
    options:
      show_root_heading: true
      heading_level: 3
