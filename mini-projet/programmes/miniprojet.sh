#!/bin/bash

# Vérifier que deux arguments sont fournis
if [[ -z $1 || -z $2 ]]; then
    echo "Ce programme a besoin de deux arguments : le fichier d'entrée et le fichier de sortie."
    exit 1
fi

fichier_entree=$1
fichier_sortie=$2
Nombre_ligne=1

# Vérifier que le fichier d'entrée existe
if [[ ! -f "$fichier_entree" ]]; then
    echo "Erreur : Le fichier d'entrée '$fichier_entree' n'existe pas ou n'est pas lisible."
    exit 1
fi

# Créer le fichier de sortie s'il n'existe pas (ou le vider)
> "$fichier_sortie"

# Écrire l'en-tête dans le fichier de sortie
echo -e "Numéro de ligne\tLien\tCode HTTP\tEncodage\tNombre de mots" >> "$fichier_sortie"

# Lire le fichier ligne par ligne
while read -r line; do
    # Code HTTP
    code_http=$(curl -s -o /dev/null -w "%{http_code}" -L "$line")

    # Encodage (on regarde l'en-tête HTTP, pas le fichier local)
    encodage=$(curl -sI "$line" | grep -i "charset" | head -n 1 | awk -F'=' '{print $2}' | tr -d '\r')

    # Nombre de mots (avec lynx si installé)
    nombre_mot=$(lynx -dump -nolist "$line" 2>/dev/null | wc -l)

    # Écrire dans le fichier TSV
    echo -e "${Nombre_ligne}\t${line}\t${code_http}\t${encodage}\t${nombre_mot}" >> "$fichier_sortie"

    ((Nombre_ligne++))
done < "$fichier_entree"

echo "✅ Le contenu a été écrit dans $fichier_sortie"
