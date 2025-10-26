#!/bin/bash

# Vérifier que deux arguments sont fournis
if [[ -z $1 ]]
then
    echo "Ce programme a besoin d'un argument : le fichier d'entrée et le fichier de sortie."
    exit 1
fi

fichier_entree=$1
fichier_sortie="./tableaux/tableau-fr.tsv"
Nombre_ligne=1

# Vérifier que le fichier d'entrée existe
if [[ ! -f "$fichier_entree" ]]
then
    echo "Erreur : Le fichier d'entrée '$fichier_entree' n'existe pas ou n'est pas lisible."
    exit 1
fi

echo -e "Numéro ligne\tlien\tCode http\tencodage\tNombre de mot" > "$fichier_sortie"
# Lire le fichier et écrire dans le fichier de sortie
while read -r line
do
    if [[ "${line}" != http* ]] 
    then
        line="https://${line}"
    fi

    code_http=$(curl -s -L -o /dev/null -w "%{http_code}" "${line}" | head -n 1 | cut -d' ' -f2)
    [[ -z "${code_http}" || "${code_http}" == "000" ]] && code_http="Erreur"

    encodage=$(curl -s -I "${line}" | grep -i "content-type" | grep -o -E "charset=[^; ]*" | cut -d= -f2) 
    [[ -z "${encodage}" ]] && encodage="Inconnu"
    nombre_mot=$(curl -s -L "${line}" | lynx -dump -nolist "${line}" | wc -w)

    echo -e "${Nombre_ligne}\t${line}\t${code_http}\t${encodage}\t${nombre_mot}" >> "$fichier_sortie"
    ((Nombre_ligne++))
done < "$fichier_entree"

echo "Le contenu a été écrit dans $fichier_sortie"

#1. le code HTTP de réponse à la requête
##1.1 les erreurs peuvent être corrigées
#2. l’encodage de la page, s’il est présent
#3. le nombre de mots dans la page