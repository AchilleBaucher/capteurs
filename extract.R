
dicocrypteur = function(){
	points=c()
	df = read.csv2("data.csv")
	names=df[1:30,4]
	for(i in names){
		data= subset(df,Medias==i)$Variable1
		points=c(points,variability(sepCat(data),data))
	}
	return(points)
}

#pts=dicocrypteur()
#plot(seq(length(pts)),pts)
#sepV1=sepCat(MYTF1_V1)[2]

#print(kVariabilite(MYTF1_V1[1:sepV1[2]],0.1))
#a=MYTF1_V1[1:150]
#print(pctEgal(a))

