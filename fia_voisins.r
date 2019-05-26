#variabilites : listes des variabilites associees à chaque capteur de la catégorie
#variabilites[capteur,variable]

NBV = 8
#La fonction associe à chaque capteur sa variabilité
fiabilites = function(variabilites){
	#Renvoie la matrice associant chaque variable de robot à sa fiabilite
	FIAB = matrix(rep(0,length(variabilites)),ncol=3)

	for(v in seq(3)){
		if(visu){cat("\nChangement ! V",v,"\n")}
		tries = sort(variabilites[,v])
		for(c in seq(length(variabilites)/3)){
			FIAB[c,v] = fiab_v(NA,variabilites[c,v])
		}
	}

	return(FIAB)
	#fiab[robot,variable]
}


#v : numéro du capteur désiré

#La fonction associe une fiabilité à une variabilité v
fiab_v = function(variabilites,v){
	#Renvoie la fiabilité d'une variabilité v dans une catégorie categorie
	#avec les donnees variabilites de tous les capteurs


	tries = sort(c(v,variabilites))
	
	indice = which(tries[tries==v])

	kmin = min
	return(fiab)
}

#Exemple de test de fiabilites
TEST = FALSE
if(TEST){
	variabilites = matrix(c(2.4,5,2.3,2,7,3,1.9,2.2,0,14,2.3,2),ncol=3)
	print(variabilites)
}

