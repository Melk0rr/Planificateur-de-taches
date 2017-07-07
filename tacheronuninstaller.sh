#!/bin/bash


if [ ! $(whoami) == "root" ]; then
    echo "Ce script doit être exécuté en superuser!";
else
    path=$(cat /etc/tacheron.path);

    if [ -f "$path"/tacherontab ]; then
        echo "Désinstallation des commandes tacherontab et tacheron..."; # On ne supprime pas le répertoire au cas ou l'utilisateur y a enregistré d'autres fichiers
        rm "$path"/tacheron*
        
        if grep -q tacheron /etc/group ; then
            echo "Suppression du groupe tacheron...";
            groupdel tacheron
        fi;

        echo "Suppression des fichiers dans le répertoire /etc...";
        rm -rf /etc/tacheron* # On supprime tout ce qui à trait à la commande tacheron

        if [ -f /var/log/tacheron.log ]; then
            echo "Suppression du fichier de logs...";
            rm -rf /var/log/tacheron* # On supprime tout ce qui à trait à la commande tacheron
        fi;

        echo "Désinstallation réussie!"
    else
        echo "Impossible de désinstaller la commande tacheron, celle-ci n'est pas installée!";
    fi;
fi;