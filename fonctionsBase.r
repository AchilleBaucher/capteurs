#Extraire les données

mini_extracteur = function(nomData,nomMedia){
	#Renvoie les données d'un seul media nomMedia
	df = read.csv2("data.csv")
	med = subset(df,Medias==nomMedia)

	return(med)
	#med$Variable1 (ou 2 ou 3)
}

EXTRACTEUR = function(nomData,nb_robots,nb_jours,visu = FALSE){
	if(visu){cat("\n----- EXTRACTION ... -----------------------------------\n")}
	#Renvoie les données de nb_robots robots
	df = read.csv2(nomData)
	names=df[1:nb_robots,4]
	data = list()

	for(i in names){
		if(visu){cat(i, "\n")}
		dataMedia = subset(df,Medias==i)
		rajouter = matrix(c((dataMedia$Variable1)[1:nb_jours],(dataMedia$Variable2)[1:nb_jours],(dataMedia$Variable3)[1:nb_jours]),nrow=3)
		if(length(rajouter[is.na(rajouter)])==0){
			data = c(data,list(rajouter))
		}
		else{
			if(visu){cat("Valeurs NA dans ",i,"\n")}
		}
	}

	if(visu){cat("\nResultat: DATA = \n")}
	if(visu){print(data)}
	if(visu){cat("\n----- EXTRACTION TERMINEE -----------------------------------\n ")}
	return(data)
	#data[[robot]][variable,temps]
}

VARIABILITES = function(data,visu=FALSE){
	if(visu){cat("\n----- CALCUL VARIABILITES ... -------------------------------\n ")}
	#Renvoie la matrice des variabilites des 3 variables des nb_robots 
	VARS = matrix(rep(0,length(data)*3),ncol=3)

	for(i in seq(length(data))){
		for(v in seq(3)){
			serie = data[[i]][v,]
			cht = SEPTENDANCE(serie,visu=FALSE)
			VARS[i,v] = variabilite(serie,cht)
		}
	}

	if(visu){cat("\nResultat: VARS = \n")}
	if(visu){print(VARS)}
	if(visu){cat("\n----- CALCUL VARIABILITES TERMINE -----------------------------\n ")}
	return(VARS)
	#VARS[capteur,variable]
}

FIABILITES= function(VARS,CATS,visu=FALSE){
	if(visu){cat("\n----- CALCUL FIABILITES ... -----------------------------------\n ")}
	#Renvoie la matrice des fiabilites des 3 variables des nb_robots 
	FIABS = matrix(rep(0,length(CATS)*3),ncol=3)

	for(i in seq(max(CATS))){
		#Pour chaque catégorie
		if(visu){cat("\nPour la categorie ",i,":","\n")}

		num = seq(length(CATS))
		capts = num[CATS[num]==i]
		vars = VARS[capts,]

		if(length(capts)<=1){
			#cat("Pas assez de capteurs: ",length(capts),"\n")
			if(length(capts)==1){
				FIABS[capts[1],] = c(0,0,0)
			}
		}
		else{
			fiabs=fiabilites(vars)
			if(visu){print(fiabs)}
			if(visu){cat("\n")}
			FIABS[capts,] = fiabs
		}
	}
	if(visu){cat("Resultat: FIABS = \n")}
	if(visu){print(FIABS)}
	if(visu){cat("\n----- CALCUL FIABILITES TERMINE -------------------------------\n ")}
	return(FIABS)
	#FIABS[capteur,variable]
}

CATEGORIES = function(data,visu=FALSE){
	if(visu){cat("\n\n----- CALCUL CATEGORIES ... -----------------------------------\n ")}
	#Renvoie la liste des catégories de chaque capteur
	listeCat=categories(data)

	if(visu){cat("\nResultat:\n")}
	if(visu){print(listeCat)}
	if(visu){cat("\n----- CALCUL CATEGORIES TERMINE -------------------------------\n ")}
	return(listeCat)
	#listeCat[numero_capteur]
}

superplot= function(variabilites,categorie,nb_robots){
	#Affiche le plot 
	a=c()
	vars = seq(N_PLOT)/N_PLOT*(max(variabilites[categorie])-min(variabilites[categorie]))+max(variabilites[categorie])
	for(i in seq(N_PLOT)){
		a[i] = fiabilite(variabilites,categorie,nb_robots,vars[i])
	}
	plot(seq(N_PLOT),a,type='l')
}

REGARDER = function(FIABS,liste,data,CATS,VARS){
	par(mfrow = c((length(liste)),3))
	for(capteur in liste){
		for(v in seq(3)){
			plot(data[[capteur]][v,],main = paste("c",capteur," v",v,": cat=",CATS[capteur],"var=",VARS[capteur,v],"fiab=",FIABS[capteur,v]),type = 'l',ylab='data',xlab='temps')
		}
	}
}

VOIRS_VARS = function(DATA,VARS,deb = 3,nb = 4){
	x11()
	par(mfrow = c(nb,3))
	for(capteur in seq(deb,deb+nb-1)){
		for(v in seq(3)){
			plot(DATA[[capteur]][v,],main = paste("c",capteur,"v",v,": var=",VARS[capteur,v]),type = 'l',ylab='data',xlab='temps')
		}
	}
}

VOIR_CATS = function(DATA,VARS,CATS,nb=4,nbcats=1){
	for(i in seq(nbcats)){
		x11()
		par(mfrow = c(nb,3))
		ceuxla= CATS[CATS==i]
		for(j in seq(nb)){
			capteur = ceuxla[j]
			for(v in seq(3)){
				plot(DATA[[capteur]][v,],main = paste("c",capteur,"v",v,": var=",VARS[capteur,v],"cat=",CATS[capteur]),type = 'l',ylab='data',xlab='temps')
			}
		}
	}
}

VOIR_FIABS = function(DATA,VARS,CATS,FIABS,nb=4,nbcats=1){
	for(i in seq(nbcats)){
		x11()
		par(mfrow = c(nb,3))
		ceuxla = which(CATS==i)
		for(j in seq(nb)){
			capteur = ceuxla[j]
			print(capteur)
			for(v in seq(3)){
				plot(DATA[[capteur]][v,],main = paste("c",capteur,"v",v,": var=",VARS[capteur,v],"cat=",CATS[capteur],"fiab=",FIABS[capteur,v]),type = 'l',ylab='data',xlab='temps')
			}
		}
	}
}

#Attention que pour les variabilites unidimentionnelles
VOIR_FIA = function(VARS,CATS,categories=c(1),variables=c(1)){
	for(cat in categories){
		for(var in variables){
			x11()
			par(mfrow = c(2,1))
			capteurs = which(CATS == cat)

			vars = VARS[capteurs,var]
			t = seq(min(vars)-0.4,max(vars)+0.4,(max(vars)-min(vars))/100)

			courbe = c()
			for(i in seq(t)){
				courbe[i] = fiab_v(vars,t[i])
			}
			courbe = courbe / max(courbe)
			plot(density(vars),main = paste("f_intervalles Cat",cat,"Var",var," Sigma =",sigma),,ylab="P(v | V)",xlab="v")
			lines(t,courbe,col='red')
			stripchart(vars,col='red',xlim=c(min(t),max(t)))
		}
	}
	
}

MOINSFIABLES = function(FIABS,DATA,CATS,nb = 2,cats = seq(1)){
	for(c in cats){
		ordre = order(FIABS[which(CATS==c)])
		n = length(FIABS[,1])
		for(i in seq(nb)){
			ind=ordre[i]
			num = ind%%n+length(FIABS[,1])*(ind%%n==0)
			v= ind%/%n+1
			titre = paste("Capteur pas fiable! cat",c,"numero",num,"fiab=",FIABS[ind],"\n")
			x11()
			plot(DATA[[num]][v,],main=titre,type='l')
		}
		x11()
		ind=ordre[length(ordre)]
		num = ind%%n+length(FIABS[,1])*(ind%%n==0)
		v= ind%/%n+1
		titre = paste("Capteur très fiable! cat",c,"numero",num,"fiab=",FIABS[ind],"\n")
		plot(DATA[[num]][v,],main=titre,type='l')
	}
}