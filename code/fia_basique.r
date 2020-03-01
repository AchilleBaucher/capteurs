#La fiabilite est de 1 si c'est pas trop loin de la moyenne, 0 sinon
sigma = 0.2
fiabilites = function(variabilites){

	FIAB = matrix(rep(0,length(variabilites)),ncol=3)

	for(i in seq(3)){
		moyenne = mean(variabilites[,i])
		for(capteur in seq(length(variabilites[,i]))){
			FIAB[capteur,i]=(abs(variabilites[capteur,i]-moyenne)/moyenne<sigma)
		}
	}

	return(FIAB)
	#fiab[robot,variable]
}

fiab_v = function(variabilites,v){
	#Renvoie la fiabilité d'une variabilité v dans une catégorie categorie
	#avec les donnees variabilites de tous les capteurs

	#Code

	return(fiab)
}

#Exemple de test de fiabilites
TEST = FALSE
if(TEST){
	variabilites = matrix(c(2.4,5,2.3,2,7,3,1.9,2.2,0,14,2.3,2),ncol=3)
	print(variabilites)
}

