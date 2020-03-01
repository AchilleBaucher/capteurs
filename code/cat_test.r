#data[[capteur]][variable,temps]
categories = function(data,visu=FALSE){
	#Renvoie la liste des catégories de chaque capteur
	listeCat=c()

	#Code

	return(listeCat)
	#listeCat[numero_capteur]
}

#Tester pour quelques capeurs
TEST=FALSE
if(TEST){
	nomData = "data.csv"
	nb_robots = 5
	nb_jour = 100

	data = EXTRACTEUR(nomData,nb_robots,nb_jour)

	print(CATEGORIES(data))
}
