#!/usr/bin/bash

echo "Nombre de Lieu en 2016 : "
cat 2016/*/* | grep Location | wc -l > output.txt
echo "Nombre de Lieux en 2017 : "
cat 2017/*/* | grep Location | wc -l > output.txt
echo "Nombre de Lieux en 2018 : "
cat 2018/*/* | grep Location | wc -l > output.txt