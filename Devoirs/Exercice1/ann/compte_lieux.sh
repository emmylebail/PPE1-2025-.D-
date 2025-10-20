#!/usr/bin/bash

# compte_lieux prend en argument : année, mois et nombre de lieux 

#— créer un script pour établir le classement des lieux les plus cités compte_lieux.sh.
#— prendre en argument l’année, le mois et le nombre de lieux à afficher
#— accepter * pour l’année et le mois.

ANNEE=$1
MOIS=$2
NOMBRE_LIEUX=$3

if [[ ! "$ANNEE" =~ ^201(6-8)$ ]]; then 
    echo "Erreur : il manque des arguments, année invalide."
    echo "<Année> <Mois> <Nombre Lieux>"
    exit 1
fi

if [[ ! "$MOIS" =~ ^[0-9]|1[0-2]$ ]]; then
    echo "Erreur : il manque des arguments, mois introuvable."
    echo "<Année> <Mois> <Nombre Lieux>"
    exit 1
fi
Ò
if [[ ! "$NOMBRE_LIEUX" =~ ^[0-9]+$ ]]; then
    echo "Erreur : il manque des arguments, veuillez ajouter."
    echo "<Année> <Mois> <Nombre Lieux>"
    exit 1
fi

echo "Classement des lieux les plus cités en $ANNEE/$MOIS:"
grep "Location" $ANNEE/$MOIS/*.ann | awk '{print $3}' | sort | uniq -c | head -n $NOMBRE_LIEUX
