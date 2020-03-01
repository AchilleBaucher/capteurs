ETP = function(vect){ 
	#Ecart-Type Pondéré
	moyenne = mean(vect)
	ecart_type=sd(vect)

	return(ecart_type/moyenne)

}

variabilite = function(serie,cht){
	#Renvoie la variabilite d'une serie temporelle
	var = 0

	if(length(list)<2){
		return(ETP(serie))
	}
	for (i in seq(length(list) - 1)) {
		var = var + ETP(serie[list[i]:list[i+1]])*(list[i+1]-list[i])
	}

	return (var/length(serie))
}

#Tester pour une seule serie temporelle:
TEST = FALSE
if(TEST){
	serie = mini_extracteur(nomData,"@ MYTF1")$Variable1
	plot(seq(length(serie)),serie,type='l')
	print(variabilite(serie,SEPTENDANCE(serie)))
}