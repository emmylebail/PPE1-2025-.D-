#!/usr/bin/bash

ANNEE=$1
TYPE=$2

# compte_par_type 1 résultat 

grep "$TYPE" $ANNEE/*/*.ann | wc -l
