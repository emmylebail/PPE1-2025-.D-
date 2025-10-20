#!/usr/bin/bash
# compte_par_type : compte les occurrences d'un type dans les fichiers .ann d'une année donnée

ANNEE=$1
TYPE=$2

if [[ -z "$ANNEE" || -z "$TYPE" ]]
then
    echo "Erreur : arguments manquants."
    echo "Usage : $0 <Année> <type d'entité>"
    exit 1
fi

if [[ ! "$ANNEE" =~ ^201[6-8]$ ]]
then
    echo "Erreur : année invalide. Utilisez 2016, 2017 ou 2018."
    exit 1
fi

if [[ ! -d "$ANNEE" ]]
then
    echo "Erreur : le répertoire $ANNEE n'existe pas."
    exit 1
fi

# Compter les lignes contenant le TYPE (mot entier) dans les fichiers .ann
grep -w "$TYPE" "$ANNEE"/*/*.ann | wc -l