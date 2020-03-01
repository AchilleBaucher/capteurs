variabilite = function(serie,cht){
	#Renvoie la variabilite d'une serie temporelle
	var = 0

	#Code

	return(var)
}

#Tester pour une seule serie temporelle:
TEST =FALSE
if(TEST){
	serie = mini_extracteur(nomData,"@ MYTF1")$Variable1
	plot(seq(length(serie)),serie,type='l')
	print(variabilite(serie))
}