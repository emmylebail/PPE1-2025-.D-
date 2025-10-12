#!/usr/bin/bash

# compte_lieux prend en argument : année, mois et nombre de lieux 

#— créer un script pour établir le classement des lieux les plus cités compte_lieux.sh.
#— prendre en argument l’année, le mois et le nombre de lieux à afficher
#— accepter * pour l’année et le mois.

ANNEE=$1
MOIS=$2
NOMBRE_LIEUX=$3

echo "Classement des lieux les plus cités en $ANNEE/$MOIS:"
grep "Location" $ANNEE/$MOIS/*.ann | sort | uniq -c | head -n $NOMBRE_LIEUX
