#variabilites : listes des variabilites associees à chaque capteur de la catégorie
#variabilites[capteur,variable]

sigma = 0.5
#La fonction associe à chaque capteur sa variabilité
fiabilites = function(variabilites,visu = FALSE){
	#Renvoie la matrice associant chaque variable de robot à sa fiabilite
	FIAB = matrix(rep(0,length(variabilites)),ncol=3)
	for(v in seq(3)){
		if(visu){cat("\nChangement ! V",v,"\n")}
		for(c in seq(length(variabilites)/3)){
			FIAB[c,v] = fiab_v(variabilites[,v],variabilites[c,v],visu=visu)
		}
	}

	return(FIAB)
	#fiab[robot,variable]
}


#v : numéro du capteur désiré

#La fonction associe une fiabilité à une variabilité v
fiab_v = function(variabilites_v,v,visu = FALSE){
	#Renvoie la fiabilité d'une variabilité v dans une catégorie categorie
	#avec les donnees variabilites de tous les capteurs
	if(visu){cat("A",v,"le tour:\n")}
	if(visu){print(variabilites_v)}
	T = (max(variabilites_v)-min(variabilites_v))*sigma
	M = v + T/2
	m = v - T/2
	if(visu){cat("M",M,"m",m,"\n")}
	fiab = length(variabilites_v[(variabilites_v>m)&(variabilites_v<M)])/length(variabilites_v)
	if(visu){cat(fiab,"\n")}
	return(fiab)
}

#Exemple de test de fiabilites
TEST = FALSE
if(TEST){
	variabilites = matrix(c(2.4,5,2.3,2,7,3,1.9,2.2,0,14,2.3,2),ncol=3)
	print(variabilites)
}

