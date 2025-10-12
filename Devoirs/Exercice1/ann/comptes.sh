#!/usr/bin/bash

echo "Nombre de Lieux en 2016 :"
grep "Location" 2016/*/*.ann | wc -l

echo "Nombre de Lieux en 2017 :"
grep "Location" 2017/*/*.ann | wc -l

echo "Nombre de Lieux en 2018 :"
grep "Location" 2018/*/*.ann | wc -l