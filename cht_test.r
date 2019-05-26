#################################################

#sepCat : epere les changements de categorie
#	Prend les donnees
#	Renvoie la liste des separations
#	o(n)

#Nombre minimum de donnees dans une categorie:
MINCAT=24

#Pourcentage de similarite entre les moyennes
#pour qu'on puisse parler de 'meme categorie':
PCTMOY = 0.2

SEPTENDANCE = function(data,visu=FALSE){
	if(visu){
		print(data)
	}
	#Affichage des donnees
	if(visu){
		plot(seq(length(data)),data,'l',xlab='Temps',ylab='Valeur')
	}

	#Cas de non possibilite
	if(length(data)<2*MINCAT){
		print( "Erreur")
		return(seq(1))
	}

	#Segmenter les parties
	sep = seq(length(data) %/% MINCAT)
	for(i in seq(length(data) %/% MINCAT)){

		mcatn=mean(data[(i-1)*MINCAT+1:MINCAT])
		sep[i]= mcatn
	}

	#Rassembler les parties
	debCat=1
	for(i in seq(length(sep)-1)){
		if(abs((sep[i]-sep[i+1])/(sep[i]+sep[i+1]))<PCTMOY){
			sep[debCat:(i+1)]=mean(sep[debCat:(i+1)])
		}
		else{
			debCat=i+1
		}
	}


	#Faire les traits
	traits = seq(length(data))
	for(i in seq(length(sep))){
		traits[(i-1)*MINCAT+1:MINCAT]=sep[i]
	}
	#On complète au bout
	traits[(length(data)-length(data) %% MINCAT):length(data)] = traits[(length(data)-length(data) %% MINCAT-1)]
	
	#Afffichage des spérations
	if(visu){
		lines(seq(length(traits)),traits,col='red')
	}
	
	#Construction de la liste des separations
	liste=c(1)
	pres=traits[1]
	for(i in seq(traits)){
		if(traits[i]!=pres){
			pres=traits[i]
			liste=c(liste,i)
		}
	}
	return(liste)
}

#Petit test
TEST=FALSE
if(TEST){
	SEPTENDANCE(decrypteur("@ MYTF1")$Variable1)
}