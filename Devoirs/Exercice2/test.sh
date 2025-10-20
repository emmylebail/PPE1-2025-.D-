#!/usr/bin/bash
# compte_lieux.sh
# Classement des lieux les plus cités
# Arguments : année, mois, nombre de lieux
# * est accepté pour année et mois

ANNEE=$1
MOIS=$2
NOMBRE_LIEUX=$3

# Vérification des arguments
if [ $# -ne 3 ]; then
    echo "Usage : $0 <Année|*> <Mois|*> <Nombre Lieux>"
    exit 1
fi

# Validation de l'année
if [[ "$ANNEE" != "*" && ! "$ANNEE" =~ ^201[6-8]$ ]]; then
    echo "Erreur : année invalide. Choisir 2016, 2017, 2018 ou *"
    exit 1
fi

# Validation du mois
if [[ "$MOIS" != "*" && ! "$MOIS" =~ ^(0[1-9]|1[0-2])$ ]]; then
    echo "Erreur : mois invalide. Choisir 01 à 12 ou *"
    exit 1
fi

# Validation du nombre de lieux
if ! [[ "$NOMBRE_LIEUX" =~ ^[0-9]+$ ]]; then
    echo "Erreur : nombre de lieux invalide, doit être un entier."
    exit 1
fi

# Classement
echo "Classement des lieux les plus cités en $ANNEE/$MOIS :"
grep "Location" "$ANNEE/$MOIS"/*.ann 2>/dev/null | awk '{print $3}' | sort | uniq -c | sort -nr | head -n $NOMBRE_LIEUX
