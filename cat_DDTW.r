#data[[capteur]][variable,temps]

categories = function(data,visu=FALSE){
	#Renvoie la liste des catégories de chaque capteur
	n = length(data)
	sim = matrix(rep(NA,n*n),c(n,n))
	for (i in seq(n-1)){
		for (j in seq(i+1,n)){ 
			V = c(0,0,0)
			cat("i",i,"j",j,"\n")
			V[1] = simDDTW(data[[i]][1,], data[[j]][1,])
			V[2] = simDDTW(data[[i]][2,], data[[j]][2,])
			V[3] = simDDTW(data[[i]][3,], data[[j]][3,])
			sim[i,j] = sqrt(sum(V^2))
		}
	}

	ordre = order(sim)


	print(sim)
	print(order(sim))

	evolution = matrix(NA,((n-1)*n )%/% 2,n)

	maxnb=0

	for(vague in seq(2,((n-1)*n )%/% 2)){
		indice = ordre[vague-1]
		cat("Suivant! ",vague,"indice",indice,"\n")
		

		evolution[vague,] = evolution[vague-1,]

		c1 = indice %/% n + 1
		c2 = indice %% n
		cc1 = evolution[vague-1,c1]
		cc2 = evolution[vague-1,c2]

		if(is.na(cc1)){
			if(is.na(cc2)){
				maxnb = maxnb+1
				evolution[vague,c1] = maxnb
				evolution[vague,c2] = maxnb
				cat("Aucun n'a encore de catégories!                ",c1,cc1,c2,cc2,"\n")
				print(evolution[vague,])
			}
			else {
				evolution[vague,c1] = cc2
				cat("Le c2 a déjà une catégorie!                    ",c1,cc1,c2,cc2,"\n")
				print(evolution[vague,])
			}
		}
		else if(is.na(cc2)){
			evolution[vague,c2] = cc1
			cat("Le c1 a déjà une catégorie!                    ",c1,cc1,c2,cc2,"\n")
			print(evolution[vague,])
		}
		else if(cc1!=cc2){
			min = min(cc1,cc2)
			ancien = evolution[vague-1,]
			evolution[vague,which(ancien==max(cc1,cc2))] = min
			cat("Les deux ont une catégorie!                    ",c1,cc1,c2,cc2,"\n")
			print(evolution[vague,])
		}
		else {
			cat("Zut les deux sont dans la même on en fait rien!",c1,cc1,c2,cc2,"\n")
			print(evolution[vague,])
		}
	}

	print(evolution)

	listeCat=c()

	#Code

	return(listeCat)
	#listeCat[numero_capteur]
}

simDDTW = function(data1, data2){
	#Renvoie la similarité entre deux séries temporelles
	n = length(data1)
	m = length(data2)
	M = matrix(0, n, m)
	

	for (i in seq(2:n-1)){
		for (j in seq(2:m-1)){
			if(i==2 & j==2){
				M[i, j] = distDTV(data1[i-1], data1[i], data1[i+1],data2[j-1], data2[j], data2[j+1])
			}
			else if (i==2 & j>2){
				M[i, j] = distDTV(data1[i-1], data1[i], data1[i+1],data2[j-1], data2[j], data2[j+1]) + M[2, j-1]
			}
			else if (j==2 & i>2){
			  
				M[i, j] = distDTV(data1[i-1], data1[i], data1[i+1],data2[j-1], data2[j], data2[j+1]) + M[i-1, 2]
			}
			else if(i>2 & j>2){
			  
				V = c(M[i-1, j-1], M[i-1,j], M[i, j-1])
				M[i, j] = distDTV(data1[i-1], data1[i], data1[i+1],data2[j-1], data2[j], data2[j+1]) + min(V)
			}
			else{
				M[i, j] = M[1,1]*max(i,j)
			}
		}
	}
	return (M[m-1, n-1])

}


distDTV = function(x1, x2, x3, y1, y2, y3){
	#retourne le carré de la différence des dérivés 
	d1 = ((x2 - x1) + ((x3-x1)/2))/2 #Empiriquement plus robuste que d'estimé la dérivé sur seulement deux points
	d2 = ((y2 - y1) + ((y3-y1)/2))/2
	return(abs(d1 - d2))
}

#Tester pour quelques capeurs
TEST=TRUE
if(TEST){
	nomData = "data.csv"
	nb_robots = 7
	nb_jour = 100

	data = EXTRACTEUR(nomData,nb_robots,nb_jour)

	print(CATEGORIES(data))
}