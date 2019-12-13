data.csv : les données

# Les codes suivants sont généraux:

ACTION.R : la où le cde final s'exécute
base.r : les fonctions de bases 
annexes.r : fonctions annexes

# Ceux-ci sont spécifiques, créer un autre fichier avec un nom différent mais avec le même nom de fonction et qui retourne le même type de truc:

* cat_ : sépare les capeurs en plusieurs catégories
* cht_ : repère les changements de tendance d'un série
* fia_ : détermine la fiabilité de tous les capteurs
* var_ : détermine la variabilité de tous les capteurs

# Et ça voilà :

visu.r : ouais on sait pas encore

# RAPPORT
# MAIN 3

## Rapport de Projet d’Initiation

# Approche Bayésienne pour l’étude des capteurs

### AchilleBaucher

### HomerDurand

### MarcoNaguib

### Encadrant : M. ZiedBEN

### OTHMANE

### 22 Février 2019 — 5 Juin 2019


### Nous tenons à remercier M. Zied BEN OTHMANE pour sa participation et

### son aide.


## Table des matières

- 1 Introduction
   - 1.1 Git
- 2 Présentation du problème
- 3 Observation des données
- 4 Fonctions clés pour identifier les séries
   - 4.1 Repérer les changements de tendance
   - 4.2 Repérer les données plafonnées
- 5 Classifier les capteurs
   - 5.1 Classification Ascendante Hiérarchique
      - 5.1.1 Derivative Dynamic Time Warping
      - 5.1.2 Classification Ascendante Hiérarchique
      - 5.1.3 Problématique rencontrée avec CAH
   - 5.2 Algorithme de K-means
   - 5.3 Classification des capteurs
   - 5.4 Résultats de la classification
- 6 Déterminer la variabilité des séries temporelles
   - 6.1 Variabilité ETP
- 7 Déterminer les fiabilités des capteurs d’une catégories
   - 7.1 Fiabilité par intervalles
   - 7.2 Fiabilité par distance de ses voisins
- 8 Résultat final
   - 8.1 Demonstration pour une catégorie
- 9 Conclusion


## 2 Présentation du problème

## 1 Introduction

Dans le cadre de notre formation en mathématique et informatique à l’école d’ingénieurs
Polytech Sorbonne, nous sommes amenés à réaliser des projets d’initiation qui combinent les
connaissances mathématiques et algorithmiques à des application en informatique et
robotique. Nous, AchilleBaucher, HomerDurandet MarcoNaguib, avons choisi ce sujet
sous l’encadrement de M. ZiedBen Othmane, qui s’intéresse à l’étude des capteurs, en
particulier le degré de fiabilité des capteurs.

Imaginons qu’on dispose d’un grand nombre de capteurs qui réalisent des mesures sur une
période de temps. Les valeurs mesurées par ceux-ci ne peuvent jamais être exactement égales
aux valeurs réelles. En effet, ces capteurs subissent constamment des bruits externes et des
déficiences internes, on ne peut donc pas faire aveuglément confiance à ces mesures. Dans ce
projet, on se propose d’étudier et de programmer des outils qui permettent de comparer les
valeurs mesurées par les capteurs entre elles, afin d’avoir une idée sur la fiabilité de chacun
des capteurs.

### 1.1 Git

Le code est disponible à cette adresse :
https://github.com/acSpinoza/capteurs.git
Il faut exécuter le fichier ACTION.R pour obtenir les résultats. Un README.MD est
disponible pour plus d’informations sur le code.

## 2 Présentation du problème

Nous avons à notre disposition _N_ capteurs notés _ci_ pour 1 ≤ _i_ ≤ _N_ , qui effectuent chacun M
mesures au cours d’une période de temps. Nous avons pu récupérer l’ensemble des séries
temporelles mesurées par les capteurs. La série temporelle mesurée par le _i_ -ième capteur est
une suite à valeurs réelles( _ci,t_ ) 1 ≤ _t_ ≤ _M_. Notre mission est alors de créer un outil informatique
qui sera capable d’identifier les capteurs les moins fiables, ceux qui ont une grande chance
d’être déficients.

_Dans notre cas, on dispose deN_ = 630 _capteurs qui sont des robots qui pointent vers des sites
web de magazines différentes. Chaque capteur mesure trois variables concernant ces sites web,
(par exemple, nombre de visiteurs, nombre de bannières, etc.). On effectue la mesure de ces 3
variables M=350 fois sur une année. Or, ces valeurs mesurées par les capteurs ne sont pas
exactes : Une bannière peut ne pas être prise en compte, un visiteur peut être compté deux
fois..._

Le but de ce projet sera d’étudier, pour chacune de ces trois variables,( _ci,t_ ) 1 ≤ _i_ ≤ _N,_ 1 ≤ _t_ ≤ _M_ , c’est
à dire toute les mesures effectuées par tous les capteurs, afin d’attribuer à chacun des capteurs
un degré de fiabilité, autrement dit, une probabilité que ses mesures soient vraies. Pour cela, il
faudra procéder par étapes :
— **Classifier les capteurs (section 5) :**
Bien que les capteurs mesurent tous le même type de données, ceux-ci peuvent provenir
de sources appartenant à des catégories _λ_ différentes. La première étape consiste donc
à identifier les différentes catégories auxquelles chaque capteur appartient.


## 3 Observation des données

```
Dans notre cas, les données proviennent de sites web de magazines variés, qui peuvent
appartenir aux catégories sport, information en direct, voyages, etc. Nous pourront
identifier les différentes catégories existantes à partir des variations et tendance des
données récupérées : hausse pendant les évènements sportifs, en vacances, etc.
— Définir une variabilité (section 6) :
Pour identifier la fiabilité d’un capteur, nous avons décidé de nous appuyer
principalement sur sa variabilité v par rapport à celles des autres capteurs de sa
catégorie. La deuxième étape consiste donc à déterminer une mesure pertinente de la
variabilité des séries renvoyées par chaque capteur.
— Déterminer la fiabilité pour chaque capteur (section 7) :
Nous pouvons alors analyser chaque catégorie, et y identifier les capteurs dont la
variabilité est trop différente des autres. Ils seront considérés comme les moins fiables.
Nous avons remarqué que la plupart de nos séries avaient une variabilité très grande,
avec des écarts grands et fréquents : les capteurs les plus constants seront donc
interprétés comme potentiellement déficients.
```
## 3 Observation des données

Les données sur lesquelles nous travaillons peuvent prendre des formes diverses que nous
avons observé pour mieux adapter nos outils futurs. Ce sont généralement des séries très
variables, comme le montre le graphique suivant.

```
Figure1 – Une série très variable
```
Il est fréquent d’observer des changements de tendance très brusques, comme on peut le voir
sur ce graphique :


##### 3 OBSERVATION DES DONNÉES

```
Figure2 – De brusques changements de tendance
```
Parfois, les données présentent un plafond, qui est très souvent atteint. Il est assez probable
que ce type de capteur soit déficient :


##### 3 OBSERVATION DES DONNÉES

```
Figure3 – Un capteur plafonné
```
Sur un même site, les données des trois robots sont parfois très corrélées, parfois moins.

```
Figure4 – Corrélations sur un même robot
```

##### 3 OBSERVATION DES DONNÉES

Entre les différents sites, on observe plus rarement des corrélations.

```
Figure5 – Corrélation entre différents robots
```

## 4 Fonctions clés pour identifier les séries

## 4 Fonctions clés pour identifier les séries

Dans l’idée de proposer une mesure de variabilité des données pertinentes, nous avons créé
plusieurs fonction pouvant nous permettre d’identifier les propriétés des séries temporelles qui
sont analysées.

### 4.1 Repérer les changements de tendance

Nous avons remarqué de très forts changements d’échelle selon les périodes d’une même série
temporelle (voir figure Tendances). Il est donc nécessaire de distinguer ces différentes périodes
pour pouvoir les analyser indépendemment : c’est le rôle de la fonctionSEP_TENDANCES, qui
renvoie les différents instants de changement de tendance, sous forme de liste.

**Fonctionnement :**
On commence par séparer la série en plusieurs intervalles (de taille fixée par le paramètre
MINCAT), et à calculer des moyennes pour chacun d’entre eux. Ensuite, on examine chaque
intervalle pour déterminer si sa moyenne est proche de celle de son voisin : c’est à dire si leur
différence est plus petite qu’un pourcentagePCTMOYde leur valeur. Si c’est le cas, on fusionne
les deux intervalles et on en déduit une nouvelle moyenne. Sinon, on passe à la suite. Les
différents intervalles et leurs moyennes correspondantes sont représentés sur ce graphique :

```
Figure6 – Résultats de la fonctionSEPCAT
```
_Nous pouvons voir ci dessus que les principaux changements de tendance sont en 217 et en_


## 5 Classifier les capteurs

_265._ Nous avons remarqué après différents tests que de bonnes valeurs pour les paramètres
étaient :
MINCAT= 24
PCTMOY= 0.

### 4.2 Repérer les données plafonnées

La fonctionpctEgalindique quel pourcentage la valeur maximale occupe dans les données. Si
elle occupe un trop gros pourcentage, on en déduit que les données sont plafonnées

```
Figure7 – Un plafond repéré par la fonctionpctEgal
```
_On peut voir sur cette figure que le plafond est atteint 77% du temps_

## 5 Classifier les capteurs

Comme l’on a vu précedemment, il est utile de classer les capteurs en catégories (clusters) en
fonction de leurs valeurs et de la forme de leurs séries temporelles. Dans notre exemple,
chaque capteur pointe vers un site web d’une magazine. Il peut être intéressant de séparer les
magazines pointées en fonction de leurs catégories (sport, voyage, etc) pour ensuite pouvoir
comparer chaque capteur à ses "voisins" de la même catégorie et non à tous les capteurs. En
effet, les magazines d’une même catégorie ayant des tendances similaires (les magazines de
voyage ayant un maximum de visiteurs en avril/mai par exemple), il est plus intéressant de


##### 5 CLASSIFIER LES CAPTEURS

comparer les capteurs correspondants entre eux, qu’à un capteur d’une autre catégorie,
(magazine de sport par exemple).

### 5.1 Classification Ascendante Hiérarchique

Afin de classer les capteurs en catégories cohérentes et pouvoir ensuite étudier leurs
variabilités au sein de celles-ci, nous avons utilisé un algorithme de "Classification Ascendante
Hiérarchique" dit CAH. Nous avions besoin, pour pouvoir l’exécuter, d’une mesure de
similarité ou de dissimilarité entre deux séries temporelles _s_ 1 et _s_ 2 de longueur _N_.

#### 5.1.1 Derivative Dynamic Time Warping

La première et plus simple méthode pour mesurer la similarité entre deux séries temporelles
est la distance euclidienne "Euclidian Distance" (ED). Nous noterons cette distance _dED_ et la
définissons comme suit :

```
dED ( s 1 ,s 2 ) =
```
```
√√
√√ 1
N
```
```
∑ N
i =
```
( _s_ (^1) _i_ − _s_ (^2) _i_ )^2 (1)
On obtient ainsi une première idée de similarité entre deux série temporelle mais qui ne tient
pas compte des dépendances temporelles. Il nous a donc paru intéressant de rechercher des
méthodes de calcul de similarité plus adaptées à nos besoins.
Nous voulons, en effet, classer les séries en différentes catégories en fonction de leur forme.
On introduit alors une nouvelle méthode de calcul, Le "Dynamic Time Warping" (DTW) [3]
qui permet de tenir compte des déformations temporelles. Cet algorithme consiste à faire
correspondre les sous séquences qui se ressemblent, même si elles sont déphasées. Cette
distance DTW est alors définie par :
_dDTW_ ( _s_ 1 _,s_ 2 ) = _min_
√√
√√∑ _K
k_ =
_dED_ ( _k_ ) (2)
avec _n_ ≤ _K_ ≤ 2 _n_ la taille du chemin parcouru. L’idée étant de calculer une matrice des
chemins reliants les premiers et derniers points en minimisant la distance cumulée, (voir figure
10).


##### 5 CLASSIFIER LES CAPTEURS

```
Figure8 – Comparaison DTW et DDTW
```
On remarque donc que les sous séquences se ressemblant sont reliés avec la distance DTW
quand la distance euclidienne se contente de relier les points ayant une même abscisse.

```
Figure9 – Comparaison des matrices avec chemin euclidien et DTW
```

##### 5 CLASSIFIER LES CAPTEURS

On a ici en vert le chemin choisit par la distance euclidienne _dED_ et en rouge celui choisit par
une distance DTW _dDTW_ afin de minimiser la distance.
Il existe plusieurs façon de définir ce chemin, nous avons choisit le celui décrit par le schéma
A :

```
Figure10 – Chemin pour DTW
```
On calcule donc une matrice _MDTW_ des distances de taille N×N comme suit :
On initialise la matrice avec _MDTW_ (1, 1) =| _s_ 1 (1)− _s_ 2 (1)|, puis les premières lignes et
colonnes :
_MDTW_ (1, j) =| _s_ 1 ( _j_ )− _s_ 2 (1)|+ _MDTW_ (1 _,j_ −1)avec j > 1
_MDTW_ (i, 1) =| _s_ 1 (1)− _s_ 2 ( _i_ )|+ _MDTW_ ( _i_ − 1 _,j_ )avec i > 1
Enfin, on calcule les valeurs des autres cases pour i + j > 2 :
_MDTW_ (i, j) =| _s_ 1 ( _j_ )− _s_ 2 ( _i_ )|+ _min_ ( _MDTW_ ( _i_ − 1 _,j_ −1) _,MDTW_ ( _i,j_ −1) _,MDTW_ ( _i_ − 1 _,j_ ))

Mais cette algorithme peut amener à des alignement de séquence non désirables dans notre
cas car nous cherchons à reconnaître des patterns qui apparaîtrait sur des périodes similaires.
Dans l’article "Derivative Dynamic Time Warping" [4] E.J.Keogh et M.J.Pazzani proposent
une méthode qui répond à cette problématique.
On cherche désormais non plus à minimiser les distances cumulés entre les séries mais à
minimiser leurs dérivées. On remplit donc une matrice _MDDTW_ avec maintenant les distances
entre les dérivées respectives des séries étudiées puis on lui applique les même algorithmes que
pour la distance DTW. Il existe plusieurs méthodes plus ou moins complexes pour calculer la
dérivées d’une série discrète, nous avons choisit celle proposeée par Keogh et Pazzani pour sa
simplicité de calcul :

_dx_ ( _s_ (^1) _i_ ) =
( _s_ (^1) _i_ − _s_ (^1) _i_ − 1 ) + ( _s_ (^1) _i_ +1− _s_ (^1) _i_ − 1 ) _/_ 2
2

##### (3)


##### 5 CLASSIFIER LES CAPTEURS

```
Figure11 – Comparaison des distances DDTW et DTW
```
Cette méthode, comme on peut le voir, fournit de meilleurs performances en minimisant le
nombre de points "dupliqués" et rend ainsi mieux compte de la correspondance entre les
formes des séries.

Toutefois la mesure de similarité par la distance DDTW peut s’avérer coûteuse en temps de
calcul car elle possède une complexité en _o_ ( _n_^2 )contrairement à la mesure de la distance
euclidienne qui a une complexité en o(n).

Nous avons désormais un outil intéressant nous permettant de mesurer la similarité entre
deux séries temporelles et pouvons donc chercher à les classer par catégories.

#### 5.1.2 Classification Ascendante Hiérarchique

Cette méthode de classification consiste à répartir un ensemble d’individu dans un certain
nombre de classes. Cette méthode est dite ascendante car elle part d’une situation où tous les
individus forment leurs propres classes puis sont rassemblés dans des classe de plus en plus
grandes à chaque itération jusqu’à obtenir une unique classe. On peut alors choisir le nombre
de classe que l’on souhaite garder en remontant l’arborescence de la classification.
Le principe de cet algorithme est simple. Initialement, chaque série est seule dans une classe,
nous avons donc n classes pour n séries. A chaque itération on fusionne deux classes réduisant
ainsi le nombre de classe. Les classes fusionnant sont celles qui sont les plus proches, c’est à
dire celles qui sont les plus similaires.

```
Figure12 – dendogramme CAH
```

##### 5 CLASSIFIER LES CAPTEURS

On voit ici qu’on commence par regrouper dans une classe les séries 4 et 5 qui sont les plus
similaires. On voit ensuite que les séries les plus similaires sont les 3 et 4, on ajoute donc la 3
à la classe créée précédemment.

```
Figure13 – dendogramme CAH
```
On regroupe ensuite les séries 8 et 9 et les séries 7 et 6 dans deux classes.

```
Figure14 – dendogramme CAH
```
On continue de la sorte jusqu’à obtenir une unique classe dans laquelle se trouve toute les
séries classées.

Il nous reste alors à choisir à quel niveau de l’arborescence on souhaite revenir pour avoir le
nombre de classe voulu.

#### 5.1.3 Problématique rencontrée avec CAH

Nous avons donc testé notre algorithme pour plusieurs capteurs. Mais nous avons remarqué
qu’il créé très peu de classes et que celles-ci disparaissaient très vite. Comme on le voit sur la
figure ci-après, tous les capteurs sont d’abord dans leurs propres classes et sont donc notées
NA. Les capteurs 5 et 6 sont ensuite regroupés dans la classe 1. Puis une nouvelle classe 2 est
créée avec les capteurs 3 et 4. Mais cette classe fusionne à l’itération suivante avec la classe 1.
Et finalement, tous les autres capteurs s’y ajoutent et aucune nouvelle classe n’est créée.


##### 5 CLASSIFIER LES CAPTEURS

```
Figure15 – En abscisse les capteurs (de 1 à 7) et en ordonnée les itérations (de 1 à 21)
```
Nous avons donc cherché des méthodes plus efficaces et répondant mieux à nos attentes pour
classer nos capteurs.

### 5.2 Algorithme de K-means

Dans un premier temps nous allons introduire une des méthodes de clustering (classification)
les plus utilisées, l’algorithme des k-means [2], développé par James McQueen en 1967. Étant
donné un grand nombre de points en dimension _n_ ≥ 1 , on veut les classer dans des catégories,
de façon à ce que les points de chaque catégorie soient les plus proches^1 possibles, et que les
centres des catégories soient les plus éloignés possibles. Il s’agit d’un problème de complexité
non polynomiale ; ce qui n’est pas pratique du moment qu’il s’agit d’un grand nombre de
points, comme ici. L’algorithme des k-means donne une solution polynomiale à ce problème.

Posons _n_ = 2, et supposons que l’on traite de 500 points, et que, en représentant les points sur
un graphe (figure 16), on obtient la figure de gauche. On veut que les catégories obtenues
correspondent, par exemple, à la figure de droite.

On précise à l’algorithme qu’on veut une classification en _k_ = 3catégories L’algorithme part
de 3 points au hasard, et crée 3 classes de points de la manière suivante : un point appartient
à la classe _i_ si, entre les 3 points considérés, le point _i_ lui est le plus proche. Une fois tous les
points classés dans les 3 catégories, on calcule le centre de chaque catégorie (on prend la
moyenne sur chaque coordonnée), on a maintenant les 3 centres des 3 catégories.

1. au sens euclidien


##### 5 CLASSIFIER LES CAPTEURS

```
Figure16 – Points classés en 3 catégories
```
Maintenant, on re-classe tous les points en fonction de leurs proximités respectives des
centres. Puis on recalcule les nouveaux centres et on réitère le processus. L’algorithme s’arrête
seulement quand il n’y a plus de changement entre l’itération _n_ et l’itération _n_ + 1. Les classes
ainsi obtenues à l’itération _n_ minimisent (au moins localement) la somme des distances entre
les points de chaque catégorie entre eux.

Il est possible de prouver que cet algorithme converge toujours, il existe pourtant de rares cas
où la solution donnée par celui-ci ne correspond pas à la meilleure solution au niveau
pratique. Ça reste quand même un algorithme assez optimisé pour résoudre un problème qui
est à priori de complexité non polynomiale.

### 5.3 Classification des capteurs

Les données qu’on a récupérées sont dans un fichiercsv. Chaque ligne indique, pour un
instant donné, et pour un capteur donné, les 3 variables mesurées.

On va s’intéresser à une seule des trois données, _var_ 1 par exemple. On veut avoir une matrice
_D_ de 610 lignes, et de 350 colonnes, telle que _di,j_ représente la _j_ -ième mesure de la variable
_var_ 1 réalisée par le _i_ -ème capteur. Pour cela, on a utilisé la programmation python pour gérer
le chaînes de caractères et rendre cette matrice. Maintenant, chacun des 610 capteurs est
représenté par un vecteur de 350 composantes, qui sont sur la ligne correspondante dans la
matrice D. On peut donc, au moins numériquement, associer à chacun de ces capteurs un
point (de dimension 350 !) et ensuite appliquer à l’ensemble des 610 points l’algorithme des
k-means comme précédemment. Deux capteurs seront donc classés dans la même catégorie si
les vecteurs représentants les valeurs mesurés par chacun d’eux sont proches au sens euclidien.
Ainsi, chaque catégorie devrait contenir de capteurs qui ont mesuré des valeurs relativement
proches pour toutes les mesures. Il sera donc pertinent de comparer ces deux capteurs entre
eux plutôt qu’un troisième capteur qui n’appartient pas à la même catégorie.


##### 5 CLASSIFIER LES CAPTEURS

### 5.4 Résultats de la classification

On a classifié les capteurs en 60 catégories. On choisit ensuite de représenter sur un graphe les
mesures par les capteurs appartenant à une catégorie donnée, voici ce les mesures réalisées par
des capteurs appartenant à la même catégorie.

```
Figure17 – catégorie 5
```
```
Figure18 – catégorie 14
```
```
Figure19 – catégorie 18
```

## 7 Déterminer les fiabilités des capteurs d’une catégories

```
Figure20 – catégorie 40
```
## 6 Déterminer la variabilité des séries temporelles

### 6.1 Variabilité ETP

Une première mesure de la variabilité de séries temporelles que nous avons utilisé est un
écart-type pondéré par la moyenne (ETP) de valeurs de la série _X_ : :

```
ν ( X ) =
```
```
σ ( X )
X
```
##### (4)

Ce choix est justifié par l’observation que les variances des séries étaient généralement
proportionnelles à leur moyenne locale. De plus, comme nous l’avons expliqué dans la section
4.1, nous avons remarqué que chaque série temporelle était soumise à des changements de
tendances. Il nous a parût dès lors plus intéressant de calculer les variabilités _νi_ sur chacune
des sous séries _Xi_ puis de calculer la moyenne de ces variabilités afin d’obtenir une variabilité
globale _ν_ pour l’ensemble de la série.

```
ν ( X ) =
```
##### 1

```
n
```
```
∑ n
```
```
i =
```
```
ν ( Xi ) (5)
```
Avec _n_ le nombre de sous-séries de _X_.
Nous avons remarqué au cours de nos essais que cette mesure de la variabilité convenait tout
à fait à notre analyse et c’est donc elle que nous avons utilisé.

## 7 Déterminer les fiabilités des capteurs d’une catégories

Les deux étapes précédentes nous fournissent l’ensemble des variabilités _vj,j_ ∈{ 1 _,...,N_ }des
capteurs de chaque catégorie. On se concentre à présent sur une catégorie _λ_ , et on essaie de
déterminer la fiabilité de chacun de ses capteurs en comparant leur variabilité à celles de
l’ensemble de leur catégorie. La fiabilité _f_ ( _ca_ )du capteur _ca_ dans une catégorie _λ_ ( _ca_ )est la
probabilité que sa variabilité _va_ soit correcte sachant toutes les variabilités de sa catégorie :
Soit _Va_ l’évènement : la variabilité _va_ est correcte. La fiabilité est alors :

```
f ( ca ) = P ( Va |{ vi,i ∈{ i/λ ( ci ) = λ ( ca )}}) (6)
```
Notre objectif est donc de trouver des fonctions pertinentes qui calculent cette probabilité.


##### 7 DÉTERMINER LES FIABILITÉS DES CAPTEURS D’UNE CATÉGORIES

### 7.1 Fiabilité par intervalles

**Idée :**
L’idée de la fonctionf_intervallesest de prendre un intervalle _Ica_ centré en la variabilité
_vca_ du capteur _ca_ en question et de retourner la proportion des capteurs de sa catégorie qui
appartiennent à cet intervalle. Ainsi, les intervalles centré en les valeurs les plus éloignées des
autres donneront une très faible fiabilité.

Figure21 – Une bonne (vert) et mauvaise (violet) valeur de variabilité parmi les autres de la
catégorie

Une difficulté réside dans le choix de la taille _T_ de l’intervalle. On peut la déterminer comme
une proportion (dépendante d’un paramètre _σ_ ) de la distance qui sépare les bornes de
l’ensemble des variabilités de la catégorie.

```
Tλ = σ ( max ( vλ )− min ( vλ )) (7)
```
**Premiers résultats :** Nous avons donc essayé cette fonction pour plusieurs valeurs de _σ_ et
deux variables d’un capteur :


##### 7 DÉTERMINER LES FIABILITÉS DES CAPTEURS D’UNE CATÉGORIES

```
Figure22 – En rouge les courbes des fonctions f_intervalles et en noir les densités
```
Les densités ont été calculées par la fonctiondensity(en noir) de matlab pour vérifier la
pertinence de notre fonctionf_intervalle(en rouge). En bas du graphiques, ce sont la
répartition des variabilités des capteurs qui est représentée, pour nous aider aussi à estimer la
précision de notre fonction.
On remarque que pour _σ_ = 0_._ 2 les courbes ont l’air plus justes et paraissent même plus
pertinentes que les densités. Mais nous avons réalisé plus tard que plus les capteurs que l’on
considéraient étaient nombreux, plus une valeur faible de _σ_ est pertinente, Nous avons donc
choisi dans la suite un _σ_ = 0_._ 1.
C’est donc cette fonction et cette valeur de _σ_ qui nous servira dans la suite pour déterminer la
fiabilité de chaque capteur.

### 7.2 Fiabilité par distance de ses voisins

L’idée de la fonctionf_dist_voisinsest de considérer l’ensemble _Vca_ des voisins les plus
proches de la variabilité _vca_ du capteur _ca_ en question et de retourner l’inverse de la somme
des distances avec _vca_ au carré. On décide au début le nombre de voisins qu’on va prendre, il
parait optimal de le fixer autour de 10.


## 8 Résultat final

```
Figure23 – Deux courbes associées à deux catégories différentes
```
Nous avons abandonné cette façon de mesurer les fiabilités car elle nous paraît beaucoup
moins précise que la précédente.

## 8 Résultat final

Nous avons donc pu :
— Classifier nos capteurs dans plusieurs catégories différentes, grâce à l’algorithme des
k-means.
— Déterminer pour chacun une valeur de variabilité, avec la fonctionvariabilite_ETP.
— En déduire une fiabilité pour chacun des capteurs, avec la fonctionf_intervalles.
Il ne nous reste à présent qu’à parcourir chaque catégorie et à repérer les capteurs avec les
valeurs de fiabilité les plus faibles, pour constater si effectivement ils diffèrent des autres.

### 8.1 Demonstration pour une catégorie

**Clustering :**
Nous choisissons arbitrairement de former 20 catégories et l’algorithme des k-means nous
renvoie la répartition suivante :

```
Figure24 – Le tableau contenant la catégorie de chaque capteur
```

##### 8 RÉSULTAT FINAL

Nous remarquons une forte présence de la catégorie 17, à laquelle nous pouvons nous
intéresser. On affiche alors toutes les les courbes de la catégorie sur un même graphique :

```
Figure25 – Les courbes de toutes les capteurs de la catégorie 17
```
**Variabilités et fiabilités**
Les variabilités sont calculées et on obtient la répartition suivante :


##### 8 RÉSULTAT FINAL

Figure26 – Répartition des variabilités de la catégorie 17 (en bas), et les résultats de l’étude
des fiabilités de cette catégorie (en haut, rouge)

On remarque que certains points, sont très différents des autres, la catégorie comporte donc
sûrement des capteurs déficients. Nous demandons donc au programme de renvoyer les 2
capteurs les moins fiables de cette catégorie, ainsi que deux capteurs très fiables pour avoir un
élément de comparaison. En affichant les courbes de ces 4 capteurs :

Figure27 – Comparaison de deux capteurs déficients (en haut) et de capteurs fiables (en bas)


##### RÉFÉRENCES

On s’aperçoit effectivement que les capteurs les repérés par notre algorithme comme déficients
ont une forme très étrange par rapport aux autres.

## 9 Conclusion

Finalement ce projet aura été pour nous une première approche de l’analyse statistique.
Dans un premier temps, il nous aura permis de nous familiariser avec certains outils très
utilisés dans ce domaine qui nous seront très certainement utiles dans la suite de nos études et
de notre parcours professionnel ou universitaire. C’est le cas de l’algorithme des K-means, des
distances Dynamic Time Warping et Derivated Dynamic Times Warping et de la
Classification Ascendante Hiérarchique.
Dans un second temps, nous avons pu développer nos propres outils et algorithmes afin de
répondre à notre problématique. Certain ayant de très bons résultats comme la mesure de
variabilité ETP (Ecart-type pondéré), la fiabilité par intervalles ou le repérage des
changements de tendances.

Bien que notre système aboutissent à des résultats concrets, nous avons remarqué durant
notre analyse plusieurs pistes d’amélioration de l’algorithme. Premièrement, le nombre de
catégories est pour l’instant choisi arbitrairement, mais nous avons vu lors de notre
documentation des méthodes qui permettraient de l’estimer et qui pourraient donc être
intéressantes de développer. Ensuite, nous avons remarqué que les capteurs pouvaient être
fiables durant une période et aberrants durant une autre : il serait donc judicieux de préciser
notre algorithme en renvoyant les périodes durant chaque capteur est fiable ou non.

## Références

[1] Classification ascendante hiérarchique.

[2] A. H. Djeffal. Clustering.
[http://www.abdelhamid-djeffal.net/web_documents/diaposclustering.pdf,](http://www.abdelhamid-djeffal.net/web_documents/diaposclustering.pdf,) Septembre
2017.

[3] J. C. Donald J. Berndt. Using dynamic time wrapping to find patterns in time series.
Avril 1994.

[4] M. J. P. Eamonn J. Keogh. Derivated dynamic time wrapping.

[5] A. J. P. M. M. S. EHala Najmeddine, Frédéric Suard. Mesures de similarité pour l’aide à
l’analyse des données énergétiques de bâtiments. Janvier 2012.


