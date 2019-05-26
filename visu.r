decrypteur = function(nomMedia){
	df = read.csv2("data.csv")
	med = subset(df,Medias==nomMedia)
	return(med)
}


V1 = decrypteur('@ MYTF1')$Variable1
V2 = decrypteur('@ LES ECHOS')$Variable1
V3 = decrypteur('@ RMC SPORT')$Variable3


par(mfrow=c(2,2))
COMPARATOR = function(nb,cols,nb_jours = -1,redim=FALSE){
	df = read.csv2("data.csv")
	noms = c()
	for(i in df[nb,4]){
		noms = c(noms,i)
	}
	cols = c('red','green','blue','black','pink','yellow','brown','grey')
	m=0
	TRUC = list()
	for(nom in noms){
		V = decrypteur(nom)$Variable2
		m = m + mean(V)
		TRUC[[nom]] = V
	}
	m = m / length(TRUC)
	
	plot(NULL, xlim=c(0,350), ylim=c(0,4*m), ylab="y label", xlab="x lablel")
	for(i in seq(length(noms))){
		print(i)
		print(noms[i])

		V = TRUC[[noms[i]]]

		if(redim){
			V = V/mean(V)*m
			TRUC[[noms[i]]] = V
		}
		
		lines(V,col=cols[i])
	}
	plot(NULL, xlim=c(0,2*m), ylim=c(0,2/m), ylab="y label", xlab="x lablel")
	for(i in seq(length(noms))){
		cat("\n",noms[i],":\n")
		V = TRUC[[noms[i]]]
		liste = c(SEPTENDANCE(V),length(V))
		print(liste)
		lines(density(V),col=cols[i])
	}
}

a = 33:36
#COMPARATOR(a,redim=FALSE)
#COMPARATOR(a,redim=TRUE)


