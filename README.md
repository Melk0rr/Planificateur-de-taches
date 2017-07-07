# Planificateur de taches

## Description
Projet réalisé en **Bash** ayant pour but de créer une nouvelle commande linux permettant d'exécuter des tâches à un moment donné en lisant régulièrement un fichier ou plusieurs fichiers contenant six champs temporels sous la forme suivante:

secondes(0-3, par tranches de 15 secondes) minutes(0-59) heure(0-23) jour du mois(1-31) mois(1-12) jour de la semaine(0-6).

Puis un champ contenant la commande à exécuter.
Exemple: 0 0 0 1,15 * * date, affichera la date dans le terminal chaque premier et 15 du mois à minuit.

## Objectifs
- élaboration d'un script d'installation
- élaboration d'un script de désinstallation
- création d'une commande tacherontab permettant de planifier les tâches et dont la syntaxe est: **tacherontab -u username {-e,-l,-r}** 
⋅⋅1. -e permettant l'édition ou la création du fichier de l'utilisateur donné
⋅⋅2. -l permettant l'affichage du fichier de l'utilisateur donné
⋅⋅3. -r permettant la suppression du fichier de l'utilisateur donné
- création d'une commande tacheron chargée d'exécuter les tâches planifiées à l'heure donnée.
