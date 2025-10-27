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

    option_ssl="--insecure"

    code_http=$(curl -s -L "${option_ssl}" --max-time 5 -o /dev/null -w "%{http_code}" "${line}")

    encodage=$(curl -s -I "${option_ssl}" --max-time 5 "${line}" | grep -i "content-type" | grep -o -E "charset=[^; ]*" | cut -d= -f2) 
    [[ -z "${encodage}" ]] && encodage="Inconnu"
    encodage=$(echo "${encodage}" | tr '[:lower:]' '[:upper:]')

    # Récupérer le nombre de mots proprement
    contenu=$(curl -s -L "${option_ssl}" --max-time 20 "${line}")
    if [[ -z "${contenu}" ]]; then
        nombre_mot="Erreur"
    else
        nombre_mot=$(echo "${contenu}" | lynx -dump -nolist "${line}" | wc -w)
        nombre_mot=$(echo "${nombre_mot}" | tr -d '\n' | tr -d '\r')
    fi

    echo -e "${Nombre_ligne}\t${line}\t${code_http}\t${encodage}\t${nombre_mot}" >> "$fichier_sortie"
    ((Nombre_ligne++))
done < "$fichier_entree"

echo "Le contenu a été écrit dans $fichier_sortie"
