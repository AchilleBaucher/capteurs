#k-variabilite: pourcentage qu'elle soit k au dessus de sa moyenne
#	Prend les donnees d'une meme categorie
#	Sors la k-variabilite
#	o(n)
kVariabilite = function(data,k){
	moyenne = mean(data)
	return(length(data[abs(data-moyenne)/(moyenne)>k])/length(data))
}

####################################################################

#pcEgalPourcentage de valeurs identiques
#	Prend des donnees d'une même catégorie
#	Dis si une valeur est particulièrement répétée
#	o(n)

pctEgal = function(data){
	plot(seq(length(data)),data,'l',xlab='Temps',ylab='Valeur')
	max=max(data)
	lines(seq(length(data)),rep(max(data),length(data)),col='red')
	return(length(data[data==max])/length(data))
	
}

####################################################################

ETP <- function(vect){ #Ecart-Type Pondéré
	moyenne = mean(vect)
	ecart_type=sd(vect)

	return(ecart_type/moyenne)

}

####################################################################

variabilite_ETP <- function(list, data){
	s=0
	if(length(list)<2){
		return(ETP(data))
	}
	for (i in seq(length(list) - 1)) {
		s = s + ETP(data[list[i]:list[i+1]])*(list[i+1]-list[i])
	}
	return (s/length(data))
}

####################################################################

#Mesure l'amplitude moyenne des changements
#	Prend les donnees
#	Renvoie l'amplitude des variations
#	o(n)
ampCh = function(data){
	difTot = 0;

	#Parcours des donnees:
	for(i in seq(length(data)-1)){

		#Addition de la variation:
		difTot=difTot+abs(data[i]-data[i+1])
	}

	#Amplitude moyenne des variations:
	return(difTot/(length(data)-1))
}
#print(ampCh(MYTF1_V1))