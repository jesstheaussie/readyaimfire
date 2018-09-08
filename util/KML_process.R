# process KML files 

require('maptools')

lastRefuge<-'/Users/wall0159/code/readyaimfire/util/doc.kml'
inDat<-maptools::getKMLcoordinates(lastRefuge, ignoreAltitude=TRUE)
lastRefugeDF<-t(as.data.frame(inDat))
names(lastRefugeDF) <- c('lat','lng')
row.names(lastRefugeDF) <- NULL

write.table(lastRefugeDF, file='/Users/wall0159/code/readyaimfire/fire_app/lastRefuge.csv')
save.image()