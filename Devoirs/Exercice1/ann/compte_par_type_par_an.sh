#!/usr/bin/bash

# compte_par_type_par_an lance 3 fois le script (3 années)

TYPE=$1

echo "Nombre de Lieux en 2016 :"
bash ./compte_par_type 2016 $TYPE

echo "Nombre de Lieux en 2017 :"
bash ./compte_par_type 2017 $TYPE

echo "Nombre de Lieux en 2018 :"
bash ./compte_par_type 2018 $TYPE