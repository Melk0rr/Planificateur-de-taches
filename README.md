# Planificateur de taches

## Description
Projet réalisé en **Bash** ayant pour but de créer une nouvelle commande linux permettant d'exécuter des tâches à un moment donné en lisant régulièrement un fichier ou plusieurs fichiers contenant six champs temporels sous la forme suivante:

secondes(0-3, par tranches de 15 secondes) minutes(0-59) heure(0-23) jour du mois(1-31) mois(1-12) jour de la semaine(0-6).

Puis un champ contenant la commande à exécuter.

Exemple: __0 0 0 1,15 * * date__, affichera la date dans le terminal chaque premier et 15 du mois à minuit.

Un champ temporel peut également contenir: 
- une __liste__ de valeurs: (1,3,5) dans le champ mois par exemple
- un __intervalle__: (1-5) dans le champ jour par exemple
- Le caractère __*__ pour signifier toutes les valeurs possibles
- une __division__: \*/5 dans le champ minute, toutes les 5 minutes
- un ou plusieurs \~nombre afin d'exprimer une __exception__: 5-8~6~7 ce qui correspond à 5,8

## Objectifs
- élaboration d'un script d'installation
- élaboration d'un script de désinstallation
- création d'une commande tacherontab permettant de planifier les tâches et dont la syntaxe est: **tacherontab -u username {-e,-l,-r}** 
  1. __-e__ permettant l'édition ou la création du fichier de l'utilisateur donné
  2. __-l__ permettant l'affichage du fichier de l'utilisateur donné
  3. __-r__ permettant la suppression du fichier de l'utilisateur donné
- création d'une commande tacheron chargée d'exécuter les tâches planifiées à l'heure donnée.
