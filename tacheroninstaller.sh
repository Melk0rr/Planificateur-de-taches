#!/bin/bash

if [ ! $(whoami) == "root" ]; then # On s'assure que le script soit bien exécuté en superuser
    echo "Ce script doit être exécuté en superuser!";
else
    if [ -f tacherontab ] && [ -f tacheron ]; then     # Si les fichiers des commandes sont bien dans le dossier courrant, on procède à l'installation
        if [ ! -f /etc/tacheron.path ]; then    # Si aucun fichier contenant le chemin d'une quelconque installation de tacheron n'existe, alors on procède à l'installation
            path="$1";
            if [ -d "$path" ]; then
                if [ ! -f "$path"/tacherontab ]; then
                    echo "Installation de la commande tacherontab...";
                    cp tacherontab "$path"  # Copie de la commande tacherontab sur le disque  
                fi;

                if [ ! -f "$path"/tacheron ]; then
                    echo "Installation de la commande tacheron...";
                    cp tacheron "$path"  # Copie de la commande tacheron sur le disque    
                fi;

                if ! grep -q tacheron /etc/group ; then
                    echo "Création du groupe tacheron...";
                    groupadd tacheron   # Création du groupe tacheron
                fi;

                echo "Gestion des droits...";
                chgrp -R tacheron "$path"  # Changement du groupe propriétaire pour les commandes
                chmod -R 770 "$path"    # Changement des droits pour les commandes
                setfacl -R -m g:tacheron:rwx "$path"    # Ajout des droits du groupe sur le dossier des commandes
                setfacl -m g:tacheron:rwx /etc/tacheron     # Ajout des droits du groupe sur le répertoire /etc/tacheron
                
                if [ ! -d /etc/tacheron ]; then
                    echo "Création du répertoire tacheron...";
                    mkdir /etc/tacheron     # Création du répertoire /etc/tacheron
                fi;

                if [ ! -f /etc/tacherontab ]; then
                    echo "Création du fichier de planification...";
                    touch /etc/tacherontab  # Création du fichier tacherontab
                fi;

                if [ ! -f /var/log/tacheron.log ]; then
                    echo "Création du fichier de logs...";
                    touch /var/log/tacheron.log     # Création du fichier des logs
                fi;

                if [ ! -f /etc/tacheron.allow ] || [ ! -f /etc/tacheron.deny ]; then
                    echo "Création des fichiers de permissions...";
                    touch /etc/tacheron.allow   # Création des fichiers d'autorisation
                    touch /etc/tacheron.deny
                fi;

                if ! grep -q "$path" /root/.bashrc ; then   # Si la commande n'est pas déjà référencée
                    echo "Référencement de la commande pour root...";
                    echo -e "\nPATH=\$PATH:$path" >> /root/.bashrc
                fi;

                line=$(grep secure_path /etc/sudoers);

                if [[ ! "$line" == *"$path"* ]]; then   # Si le chemin d'installation n'est pas déjà référencé
                    echo "Référencement de l'emplacement de la commande...";
                    length=${#line};
                    cut_line=$(echo "$line" | awk "{print substr(\$0,0,$length)}");
                    new_line="$cut_line:$path\"";
                    sed -i 's@'"$line"'@'"$new_line"'@' /etc/sudoers    # Remplacement de la ligne
                fi;

                echo "Référencement global de la commande...";
                export "PATH=\$PATH:$path"

                if [ ! -f /etc/tacheron.path ]; then
                    echo "Sauvegarde de l'emplacement des commandes...";
                    echo "$path" >> /etc/tacheron.path  # Sauvegarde de l'emplacement de l'installation
                fi;

                echo "Installation réussie!";
            else
                echo "Argument invalide, l'installation ne peut être effectuée à $path";
            fi;
        else
            echo "La commande tacheron est déjà installée!";
        fi;
    else
        echo "Installation de tacherontab impossible, fichier manquant!";
    fi;
fi;


