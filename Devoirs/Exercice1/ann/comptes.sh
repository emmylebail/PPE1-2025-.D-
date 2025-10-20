#!/usr/bin/bash

for ANNEE in 2016 2017 2018 
do 
    echo "Nombre de Lieux en $ANNEE :"
    grep "Location" $ANNEE/*/*.ann | wc -l
done
