#Meme categorie si voila
categories = function(data,visu=FALSE){
	#Renvoie la liste des catégories de chaque capteur
	listeCat=c()

	for(i in seq(length(data))){
		catCap = 0
		for(v in seq(3)){
			segment = length(data[[i]][v,])%/%2
			catCap = catCap + 2^(v-1) * (mean(data[[i]][v,(1:segment)])>=mean(data[[i]][v,(segment:(2*segment))]))
		}
		listeCat[i] = catCap+1
	}

	return(listeCat)
	#listeCat[numero_capteur]
}