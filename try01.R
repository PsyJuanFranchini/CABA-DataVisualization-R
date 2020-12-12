#Packages
install.packages("tidyverse")
install.packages("sf")

#Libraries
library(tidyverse)
library(sf)

#Importar CSV
suaci2018 <- read.csv('http://cdn.buenosaires.gob.ar/datosabiertos/datasets/sistema-unico-de-atencion-ciudadana/gcba_suaci_2018-1.csv')
barrios <- st_read('http://cdn.buenosaires.gob.ar/datosabiertos/datasets/barrios/barrios.geojson')
poblacion <- read.csv("http://cdn.buenosaires.gob.ar/datosabiertos/datasets/barrios/caba_pob_barrios_2010.csv")

#Corrección de names barrios
colnames(barrios)[1] <- "BARRIO"
colnames(barrios)[2] <- "COMUNA"
names(barrios)

#No correr que se crushea
#colnames(barrios)[3] <- "PERIMETRO"
#colnames(barrios)[4] <- "AREA"
#colnames(barrios)[5] <- "GEOMETRY"

#Comprobar el dataframe
suaci2018
dim(suaci2018)
head(suaci2018)
names(suaci2018)
dim(barrios)
names(barrios)
head(barrios)
head(poblacion)

#Graficos
  #Histo
ggplot(suaci2018) +
  geom_col(aes(x = BARRIO, y = CONTACTOS)) +
  coord_flip()

  #Mapas
ggplot(barrios) +
  geom_sf()

  #Barrios con color por comuna
ggplot(barrios) +
  geom_sf(aes(fill = factor(COMUNA)))

#Merge suaci2018+población

suaci2018 <- left_join(suaci2018, poblacion)
head(suaci2018)

#Merge barrios + suaci2018
barrios <- left_join(barrios, suaci2018)
head(barrios)

#Plot barrios: Contactos/población
ggplot(barrios) +
  geom_sf(aes(fill = CONTACTOS / POBLACION)) +
  scale_fill_distiller(palette = "Spectral")