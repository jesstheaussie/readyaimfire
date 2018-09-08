# process KML files 

require('maptools')

lastRefuge<-'/Users/wall0159/code/readyaimfire/fire_app/doc.kml'
maptools::getKMLcoordinates(lastRefuge, ignoreAltitude=TRUE)