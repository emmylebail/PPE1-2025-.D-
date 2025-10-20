#!/usr/bin/bash
# compte_par_type 1 résultat 

ANNEE=$1
TYPE=$2

if [[ ! "$ANNEE" =~ ^201(6-8)$ ]]; then 
    echo "Erreur : il manque des arguments, année invalide."
    echo "<Année> <type d'entité>"
    exit 1
fi

if [[ -z "$TYPE"]] ; then
    echo "Erreur : il manque des arguments, type d'entité manquant."
    exit 1
fi

grep "$TYPE" $ANNEE/*/*.ann | wc -l