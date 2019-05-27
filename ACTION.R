#PARAMETRES
nomData = "data.csv"
nb_robots = 610
N_PLOT = 20
nb_jours = 260
visu = FALSE

source("fonctionsBase.r")
source("cht_test.r")
source("var_ETP.r")
source("cat_binaire.r")
source("fia_intervalles.r")

#PARAMETRES
sigma = 0.1
NBV = 12


#EXTRAIRE TOUTES LES DONNEES
DATA = EXTRACTEUR(nomData,nb_robots,nb_jours,visu=visu)
#DATA[[capteur]][variable,temps]


#DONNER UNE VARIABILITE A CHAQUE CAPTEUR
VARS = VARIABILITES(DATA,visu = visu)
#VARS[capteur,variable]


#DONNER UNE CATEGORIE A CHAQUE CAPTEUR
#CATS = CATEGORIES(DATA,visu=TRUE)
source("kmeans.r")
CATS = K
print(CATS)
valeurs = valeurs_pour_kmeans(DATA)

#CATS[capteur]


#DONNER UNE FIABILITE A CHAQUE CAPTEUR
FIABS = FIABILITES(VARS,CATS,visu=visu)
#FIABS[capteur,variable]

#VISUALISER LES COURBES DE PLUSIEURS CATEGORIES

#en choisir une d'une catégorie nombreuse: 
cat = 2
while(length(CATS[CATS==cat])<50){
	cat = cat + 1
}
plusieurs_cat = c(cat)

cat("On choisit la catgéorie",cat,"qui a une taille de",length(CATS[CATS==cat]),"\n")
VOIRMARCO(CATS,valeurs,plusieurs_cat)

#VISUALISER LES FIABILITES DE PLUSIEURS CATEGORIES
VOIR_FIA(VARS,CATS,categories = plusieurs_cat,variables=c(1))


#VOIR LES MOINS FIABLES DE PLUSIEURS CATEGORIES
nbfiables = 1
nbdeficients = 1
MOINSFIABLES(FIABS,DATA,CATS,VARS,cats = plusieurs_cat,nb=nbfiables,nbf=nbfiables)
