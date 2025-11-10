"# Journal de bord du projet encadré"

## SEMAINE 1 - 24 Septembre

> Découvert du Mac et des touches spéciales :
> - Option + Maj + L -> **|**
> - Option + Maj + ( / ) -> **[**
> - Option + Maj + / -> **\**
> - Option + ( -> **{**
> - Option + N -> **~**
> - **Capture d’écran** : Maj + Commande + 3/4

Travail à faire : Classer les fichiers de l'archive dans un arbre. 
* mkdir -p [Créer dossier]

## SEMAINE 2 - 1er Octobre

Travail à faire : Créer un Tag "gitinto" avec le message "version finie intro git"

* git tag -a gitinto -m "version finie intro git"
> Supprimer un tag :
> * git tag -d gitinto
> * git push origine gitinto [Mon tag était associer à mon document]

## SEMAINE 3 - 8 Octobre

Travail à faire : Lire et expliquer ce code

```python
# !/ usr / bin / bash
if [ $ # - ne 1 ]
then
    echo " ce programme demande un argument "
    exit
fi
FICHIER_URLS=$1
OK=0
NOK=0
while read -r LINE ;
do
    echo " la ligne : $LINE "
    if [[ $LINE=∼^https?:// ]]
    then
        echo " ressemble à une URL valide "
        OK=$( expr $OK + 1 )
    else
        echo " ne ressemble pas à une URL valide "
        NOK = $ ( expr $NOK + 1)
    fi
done < $FICHIER_URLS
echo " $OK URLs et $NOK lignes douteuses "
```

> Ce code demande un argument qui est un fichier d'urls. Il va analyser ligne par ligne le document pour vérifier si les urls sont valide ou pas pour retourner le nombre de ligne douteuse.

## SEMAINE 4 - 15 Octobre

Travail à faire : 

## SEMAINE 5 - 22 Octobre

Je viens de remarquer que tout ce que j'avais écrit dans mon journal s'est supprimé, je vais voir si c'est possible de récupérer l'ancienne version de ce journal.
En fait je crois que c'est de ma faute, j'ai oublié de sauvergarder le document avant de quitter la page, quelle erreur de débutant...
Du coup on refera les exercices de la dernière fois un autre jour.

Travail à faire : 
> * Exercice 1 : lire les lignes d’un fichier en bash
Dans le dépôt vous trouverez le dossier "mini-projet" avec le code suivant :
while read -r line;
do
echo ${line};
done < "urls/fr.txt";
Questions :
> 1. Pourquoi ne pas utiliser cat ? 
* On utilise par cat car on ne veut pas ouvrir des documents différents, la fonction va chercher un document pour chaque line du fichier. 
> 2. Comment transformer "urls/fr.txt" en paramètre du script ?
* fichier_urls=$1
>> 2.1 Valider l’argument : ajouter le code nécessaire pour s’assurer qu’on donne bien un argument au script, sinon on s’arrête
```python
if [[ #$ -ne 1 ]]
then 
    echo "Ce programme a besoin d'un argument."
    exit 1
fi

Nombre_ligne=1

while read -r line
do
    echo -e "${Nombre_ligne}\t${line}"
    ((Nombre_ligne++))
done < "urls/fr.txt"
```
> 3. Comment afficher le numéro de ligne avant chaque URL (sur la même ligne) ? 
>> Si c'est comme en python, on peut essayer la fonction "index" // Pas possible, mais on peut faire un décompte.
• Bien séparer les valeurs par des tabulations

Mon terminal me rend ce résultat :

1	https://fr.wikipedia.org/wiki/Robot

2	https://fr.wikipedia.org/wiki/Robot_de_cuisine

3	fr.wikipedia.org/wiki/Robot_d%27indexation

4	https://fr.wikipedia.org/wiki/Bot_informatique

5	https://fr.wikipedia.org/wiki/Atlas_(robot)

6	https://roboty.magistry.fr

7	https://fr.wikipedia.org/wiki/Robot_(Leonard_de_Vinci)

8	https://fr.wiktionary.org/wiki/robot

9	https://fr.wikipedia.org/wiki/Protocole_d%27exclusion_des_robots

10	https://fr.wikipedia.org/wiki/Robotique


C'est pas encore ce que je veux avoir, ça veut dire qu'il y a un problème, il faut que je redirige vers un fichier de sortie. 

Je viens de voir que ce n'est que l'exercice 1. Je vais faire une pause ça sera mieux.
> * Exercice 2 : 
>1. le code HTTP de réponse à la requête
>>1.1 les erreurs peuvent être corrigées
>2. l’encodage de la page, s’il est présent
> 3. le nombre de mots dans la page

Résultat 1 :

| Numéro ligne | Lien | Code HTTP | Encodage | Nombre de mots |
|:-------------:|:------|:-----------:|:-----------:|---------------:|
| 1 | https://fr.wikipedia.org/wiki/Robot |     |   | 5668 |
| 2 | https://fr.wikipedia.org/wiki/Robot_de_cuisine |  |  | 1157 |
| 3 | fr.wikipedia.org/wiki/Robot_d%27indexation |	|   | 1756 |
| 4 | https://fr.wikipedia.org/wiki/Bot_informatique |  |   | 2577 |
| 5 | https://fr.wikipedia.org/wiki/Atlas_(robot) |   |     | 1163 |
| 6 | https://roboty.magistry.fr |  |   | 0 |
| 7 | https://fr.wikipedia.org/wiki/Robot_(Leonard_de_Vinci) |  |  | 440 |
| 8 | https://fr.wiktionary.org/wiki/robot |    |   | 4785 |
| 9 | https://fr.wikipedia.org/wiki/Protocole_d%27exclusion_des_robots |    |   | 1052 |
| 10 | https://fr.wikipedia.org/wiki/Robotique |  |  | 13009 |


J'ai à présent le fichier tableau-fr.tsv qui a été crée. Maintenant le problème est l'encodage et le code http ne sont sortis.
Lorsque j'ai lancé le programme j'ai aussi eu un problème d'accès pour le 6e lien, c'est pour ça que j'ai un résultat de 0.

> curl: (60) SSL certificate problem: certificate has expired

""" More details here: https://curl.se/docs/sslcerts.html

curl failed to verify the legitimacy of the server and therefore could not
establish a secure connection to it. To learn more about this situation and
how to fix it, please visit the web page mentioned above.

Looking up roboty.magistry.fr
Making HTTPS connection to roboty.magistry.fr
SSL callback:ok, preverify_ok=1, ssl_okay=0
SSL callback:ok, preverify_ok=1, ssl_okay=0
SSL callback:certificate has expired, preverify_ok=0, ssl_okay=0
Retrying connection without TLS.
Looking up roboty.magistry.fr
Making HTTPS connection to roboty.magistry.fr
SSL callback:ok, preverify_ok=1, ssl_okay=0
SSL callback:ok, preverify_ok=1, ssl_okay=0
SSL callback:certificate has expired, preverify_ok=0, ssl_okay=0
Alert!: Unable to make secure connection to remote host.

lynx: Can't access startfile https://roboty.magistry.fr/ """

Résultat 2 :

| Numéro ligne | Lien | Code HTTP | Encodage | Nombre de mots |
|:-------------:|:------|:-----------:|:-----------:|---------------:|
| 1 | https://fr.wikipedia.org/wiki/Robot | 200 | UTF-8 | 7567 |
| 2 | https://fr.wikipedia.org/wiki/Robot_de_cuisine | 200 | UTF-8 | 1527 |
| 3 | fr.wikipedia.org/wiki/Robot_d%27indexation | 404 | Inconnu | 1 |
| 4 | https://fr.wikipedia.org/wiki/Bot_informatique | 200 | UTF-8 | 3265 |
| 5 | https://fr.wikipedia.org/wiki/Atlas_(robot) | 200 | utf-8 | 75 |
| 6 | https://roboty.magistry.fr | 000 | Inconnu | 36 |
| 7 | https://fr.wikipedia.org/wiki/Robot_(Leonard_de_Vinci) | 200 | utf-8 | 75 |
| 8 | https://fr.wiktionary.org/wiki/robot | 200 | UTF-8 | 75 |
| 9 | https://fr.wikipedia.org/wiki/Protocole_d%27exclusion_des_robots | 200 | utf-8 | 75 |
| 10 | https://fr.wikipedia.org/wiki/Robotique | 200 | utf-8 | 75 |

La question est pourquoi il y a autant de différence entre le nombre de mot de ce résultat que dans le résultat précédent. 
Les codes d'erreur ne sont toujours pas bien enregistré...

Résultat 3 :

| Numéro ligne | Lien | Code HTTP | Encodage | Nombre de mots |
|:-------------:|:------|:-----------:|:-----------:|---------------:|
| 1 | https://fr.wikipedia.org/wiki/Robot | 200 | UTF-8 | 5668 |
| 2 | https://fr.wikipedia.org/wiki/Robot_de_cuisine | 200 | UTF-8 | 1157 |
| 3 | https://fr.wikipedia.org/wiki/Robot_d%27indexation | 200 | UTF-8 | 1756 |
| 4 | https://fr.wikipedia.org/wiki/Bot_informatique | 200 | utf-8 | 2577 |
| 5 | https://fr.wikipedia.org/wiki/Atlas_(robot) | 429 | utf-8 | 1163 |
| 6 | https://roboty.magistry.fr | Erreur | Inconnu | 0 |
| 7 | https://fr.wikipedia.org/wiki/Robot_(Leonard_de_Vinci) | 404 | utf-8 | 440 |
| 8 | https://fr.wiktionary.org/wiki/robot | 429 | utf-8 | 4785 |
| 9 | https://fr.wikipedia.org/wiki/Protocole_d%27exclusion_des_robots | 429 | utf-8 | 1052 |
| 10 | https://fr.wikipedia.org/wiki/Robotique | 429 | utf-8 | 13009 |

Le nombre de mot est revenu à la normal et les erreurs ont été récupérées. Il me manque plus que l'erreur du 6e site à contourner. L'erreur vient de la licence du site qui était jusqu'au 1er octobre. J'avais essayé de la contourné avec la commande lynx -stdin mais ça me donnait de mauvais chiffres pour les autres site.

J'ai essayé de contourné la restriction ssl avec une option `--insercure`, ça marche plutôt pas mal, le seul problème c'est que ça a déréglé le calcul du nombre des mots.

Résultat 4 :

| Numéro ligne | Lien                                                      | Code HTTP | Encodage | Nombre de mots |
|-------------:|----------------------------------------------------------|-----------|----------|----------------|
| 1            | https://fr.wikipedia.org/wiki/Robot                     | 200       | UTF-8    | 5668           |
| 2            | https://fr.wikipedia.org/wiki/Robot_de_cuisine          | 200       | UTF-8    | 1157           |
| 3            | https://fr.wikipedia.org/wiki/Robot_d%27indexation      | 200       | UTF-8    | 1756           |
| 4            | https://fr.wikipedia.org/wiki/Bot_informatique          | 200       | utf-8    | 71             |
| 5            | https://fr.wikipedia.org/wiki/Atlas_(robot)             | 429       | utf-8    | 71             |
| 6            | https://roboty.magistry.fr                               | 200       | Inconnu  | 35             |
| 7            | https://fr.wikipedia.org/wiki/Robot_(Leonard_de_Vinci)  | 429       | utf-8    | 440            |
| 8            | https://fr.wiktionary.org/wiki/robot                     | 429       | utf-8    | 71             |
| 9            | https://fr.wikipedia.org/wiki/Protocole_d%27exclusion_des_robots | 429       | utf-8    | 71             |
| 10           | https://fr.wikipedia.org/wiki/Robotique                 | 429       | utf-8    | 71             |

Je pense que les différences de résultat sont du aux codes d'erreur http, j'ai lancé plusieurs fois d'affilé le scripts bash et je n'ai pas toujours le même résultat.

-> Erreur 429 : 429 Too Many Requests. Cette erreur survient lorsque le serveur est submergé par un grand nombre de requêtes en un court laps de temps, ce qui peut être dû à une utilisation intensive du site ou à des abus.

Résultat 5 :

| Numéro ligne | Lien | Code HTTP | Encodage | Nombre de mot |
|--------------|------|-----------|----------|---------------|
| 1 | https://fr.wikipedia.org/wiki/Robot | 200 | UTF-8 | 5668 |
| 2 | https://fr.wikipedia.org/wiki/Robot_de_cuisine | 200 | UTF-8 | 1157 |
| 3 | https://fr.wikipedia.org/wiki/Robot_d%27indexation | 200 | UTF-8 | 1756 |
| 4 | https://fr.wikipedia.org/wiki/Bot_informatique | 200 | UTF-8 | 2577 |
| 5 | https://fr.wikipedia.org/wiki/Atlas_(robot) | 429 | UTF-8 | 1163 |
| 6 | https://roboty.magistry.fr | 200 | INCONNU | 0 |
| 7 | https://fr.wikipedia.org/wiki/Robot_(Leonard_de_Vinci) | 404 | UTF-8 | 440 |
| 8 | https://fr.wiktionary.org/wiki/robot | 429 | UTF-8 | 4785 |
| 9 | https://fr.wikipedia.org/wiki/Protocole_d%27exclusion_des_robots | 200 | UTF-8 | 1052 |
| 10 | https://fr.wikipedia.org/wiki/Robotique | 429 | UTF-8 | 13009 |

Pour régler un problème, j'ai enlevé l'option `-stdin` j'ai également ajouté le temps de réponse `--max-time` qui permet de ne pas trop surchauffé le site.

## SEMAINE 6 - 3 Novembre

Travail à faire : transformer la sortie tabulaire en HTML
En partant du miniprojet de la semaine dernière, nous voulons à présent transformer
la sortie tabulaire en sortie au format HTML. La page produite devra contenir :
1. un entête
2. un corps
• devra contenir au moins le tableau des données récupérées, avec une ligne
d’entête et les résultats pour chaque URL.
Ce code HTML devra être écrit dans un fichier .html qui devra être lisible par un
navigateur web quelconque.
