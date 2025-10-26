#!/usr/bin/bash

# 1-récupérer les URL contenues dans un fichier texte
# 2-écrire sur le terminal des informations séparées par des tabulations

# Etape 1 : Lecture - des fichiers de données en entrée + Nom du fichier sortie
# Etape 2 : Pour chacun des fichier d'URLs 
# Boucle - lecture du fichier ligne par ligne
# if ok ->  1. Détection d'encodage
#			2. if UTF8
#				 2.1. extraction du texte de la page
#				 2.2. ecriture du résultat
#			3. if 
#				3.1. modifier l'encodage
# if not -> ne rien faire, écrire le résultat 

if [[ $# -ne 2 ]]
then 
	echo "Ce programme demande deux arguments"
	exit 1
fi

fichier_URL=$1
fichier_sortie=$2

if [[ -f "$fichier_URL" ]]
then 
    echo "lecture de $fichier_URL"
    while read -r line
    do 
        if [ -f "$line" ]
        then 
            echo "Lecture de $line"
            encodage=$(file -i "$line" | awk -F'charset=' '{print $2}') 
                if [[ "$encodage" == "utf-8" ]]
                then 
                    echo "Le fichier est bien en utf-8"
                    cat "$line" >> "$fichier_sortie"
                else
                    echo "Le fichier n'est pas en utf-8 ($encodage)"
                    echo "Encodage en cours..."
                    iconv -f "$encodage" -t utf-8 "$line" >> "$fichier_sortie"
                fi
        else
            echo "fichier introuvable"
        fi
    done < "$fichier_URL"
else 
    echo "Fichier introuvable"
        exit 1
fi