#Data <- read.csv("Var1.csv",header=FALSE)
#noms=Data[,1]
#valeurs=Data[,2:dim(Data)[2]]
nb_categories = 30
valeurs = valeurs_pour_kmeans(DATA)
K=kmeans(valeurs,nb_categories,1000,1)$cluster
Vect = which(K==5)
#plot(1:260,valeurs[Vect[1],],type='l',main=noms[Vect],ylim=c(min(valeurs[Vect,]),max(valeurs[Vect,])))
for (i in 2:length(Vect)) {
	#lines(1:260,valeurs[Vect[i],],col=i)
}
#write.table(t(K), file="Clusters.csv",row.names=FALSE ,col.names=FALSE, sep=',')