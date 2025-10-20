#!/usr/bin/bash

# compte_par_type_par_an lance 3 fois le script (3 années)

TYPE=$1

if [[ -z "$TYPE" ]]
then
    echo "Erreur : il manque des arguments, type d'entité manquant."
    exit 1
fi

echo "Nombre de Lieux en 2016 :"
bash ./compte_par_type.sh 2016 $TYPE

echo "Nombre de Lieux en 2017 :"
bash ./compte_par_type.sh 2017 $TYPE

echo "Nombre de Lieux en 2018 :"
bash ./compte_par_type.sh 2018 $TYPE