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

# Création du document html
{
echo "<!DOCTYPE html>"
echo "<html>"
echo "<head>"
echo "<titre> Mini-projet </titre>"
echo "<meta charset=\"utf8\">"
echo "</head>"
echo "<body>"


echo "<table>"
echo "<tr>" "<th>Numéro de ligne</th>" "<th>Lien</th>" "<th>Code HTTP</th>" "<th>Encodage</th>" "<th>Nombre de mots</th>" "</tr>"
} > "$fichier_sortie"

# Lire le fichier ligne par ligne
while read -r line; do
    # Code HTTP
    code_http=$(curl -s -o /dev/null -w "%{http_code}" -L "$line")

    # Encodage (on regarde l'en-tête HTTP, pas le fichier local)
    encodage=$(curl -sI "$line" | grep -i "charset" | head -n 1 | awk -F'=' '{print $2}' | tr -d '\r')

    # Nombre de mots (avec lynx si installé)
    nombre_mot=$(lynx -dump -nolist "$line" 2>/dev/null | wc -w )

    # Écrire dans le fichier html
    {
    echo "<tr>"
    echo "<td>" ${Nombre_ligne} "</td>"
    echo "<td>" ${line} "</td>"
    echo "<td>" ${code_http} "</td>"
    echo "<td>" ${encodage} "</td>"
    echo "<td>" ${nombre_mot} "</td>" 
    echo "</tr>" 
    } >> "$fichier_sortie"
     

    ((Nombre_ligne++))
done < "$fichier_entree"

{
echo "</table>"
echo "</body>"
echo "</html>"
    } >> "$fichier_sortie"