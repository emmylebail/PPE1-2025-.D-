#!/bin/bash

# Vérifier qu'un argument est fourni
if [[ -z $1 ]]; then
    echo "Ce programme a besoin d’un argument : le fichier d'entrée."
    exit 1
fi

fichier_entree=$1
Nombre_ligne=1

# Vérifier que le fichier d'entrée existe
if [[ ! -f "$fichier_entree" ]]; then
    echo "Erreur : Le fichier d'entrée '$fichier_entree' n'existe pas ou n'est pas lisible."
    exit 1
fi

# Créer le dossier si nécessaire
mkdir -p tableaux

# Création du document html
{
echo "<!DOCTYPE html>"
echo "<html>"
echo "<head>"
echo "<title>Mini-projet</title>"
echo "<meta charset=\"utf-8\">"
echo "<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/bulma.min.css\">"
echo "</head>"
echo "<body>"

echo "<section class=\"section\">"
echo "<div class=\"container is-max-desktop\">"
echo "<div class=\"content\">"
echo "<h2 class=\"title\">Résultat du script</h2>"

echo "<table class=\"table\">"
echo "<tr><th>Numéro de ligne</th><th>Lien</th><th>Code HTTP</th><th>Encodage</th><th>Nombre de mots</th></tr>"
} > "./tableaux/tableau-fr.html"

# Lire le fichier ligne par ligne
while read -r line; do
    # Code HTTP
    code_http=$(curl -s -o /dev/null -w "%{http_code}" -L "$line")

    # Encodage (on regarde l'en-tête HTTP)
    encodage=$(curl -sI "$line" | grep -i "charset" | head -n 1 | awk -F'=|;' '{print $2}' | tr -d '\r')

    # Nombre de mots
    nombre_mot=$(lynx -dump -nolist "$line" 2>/dev/null | wc -w)

    # Ajouter au tableau
    {
    echo "<tr>"
    echo "<td>${Nombre_ligne}</td>"
    echo "<td>${line}</td>"
    echo "<td>${code_http}</td>"
    echo "<td>${encodage}</td>"
    echo "<td>${nombre_mot}</td>"
    echo "</tr>"
    } >> "./tableaux/tableau-fr.html"

    ((Nombre_ligne++))
done < "$fichier_entree"

{
echo "</table>"
echo "</div>"
echo "</div>"
echo "</section>"
echo "</body>"
echo "</html>"
} >> "./tableaux/tableau-fr.html"
