#PARAMETRES
nomData = "data.csv"
nb_robots = 100
N_PLOT = 20
nb_jours = 350
visu = FALSE

source("fonctionsBase.r")
source("cht_test.r")
source("var_ETP.r")
source("cat_binaire.r")
source("fia_intervalles.r")

#PARAMETRES
sigma = 0.2
NBV = 12


#EXTRAIRE TOUTES LES DONNEES
DATA = EXTRACTEUR(nomData,nb_robots,nb_jours,visu=visu)
#DATA[[capteur]][variable,temps]


#DONNER UNE VARIABILITE A CHAQUE CAPTEUR
VARS = VARIABILITES(DATA,visu = visu)
#VARS[capteur,variable]


#DONNER UNE CATEGORIE A CHAQUE CAPTEUR
CATS = CATEGORIES(DATA,visu=visu)
#CATS[capteur]


#DONNER UNE FIABILITE A CHAQUE CAPTEUR
FIABS = FIABILITES(VARS,CATS,visu=visu)
#FIABS[capteur,variable]

#VISUALISER LES FIABILITES DE PLUSIEURS CATEGORIES
plusieurs_cat = c(1,8)
plusieurs_var = c(1,2,3)
VOIR_FIA(VARS,CATS,categories = plusieurs_cat,variables=plusieurs_var)

