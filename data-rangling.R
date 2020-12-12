#Packages
install.packages("tidyverse")

#Libraries
library(tidyverse)

#get csv
atencion_ciudadano <- read.csv("http://cdn.buenosaires.gob.ar/datosabiertos/datasets/sistema-unico-de-atencion-ciudadana/gcba_suaci_barrios.csv")
barrios_comunas <- read.csv("http://cdn.buenosaires.gob.ar/datosabiertos/datasets/barrios/barrios_comunas_p_Ciencia_de_Datos_y_PP.csv")


#exploración de datos
str(atencion_ciudadano)
summary(atencion_ciudadano)
names(atencion_ciudadano)
levels(atencion_ciudadano$BARRIO)
head(barrios_comunas)

#Correccion a factor
atencion_ciudadano$RUBRO <- as.factor(atencion_ciudadano$RUBRO)
summary(atencion_ciudadano)

#Merge
atencion_ciudadano <- left_join(atencion_ciudadano, barrios_comunas)
head(atencion_ciudadano)

#Save dataframe as CSV  
write.csv(atencion_ciudadano, "atencion_ciudadano.csv", row.names = FALSE)

#Seleccion de columnas omitiendo un rango
seleccion <- select(atencion_ciudadano, -(TIPO_PRESTACION:total))
head(seleccion)

#filtrado de rows con dos criterios AND
seleccion <- filter(atencion_ciudadano, BARRIO == "RETIRO", PERIODO == 201401)
head(seleccion)

#filtrado de rows con OR 
seleccion <- filter(atencion_ciudadano, BARRIO == "RETIRO" | BARRIO == "PALERMO")
head(seleccion)

seleccion <- filter(atencion_ciudadano, !(TIPO_PRESTACION == "DENUNCIA" & RUBRO == "SEGURIDAD E HIGIENE"))

head(seleccion)
#Reminder
#* a & b     a y b
#* a | b     a ó b
#* a & !b    a, y no b
#* !a & b    no a, y b
#* !(a & b)  no (a y b) 

# Ordenar filas con arrange
ordenado <- arrange(atencion_ciudadano, desc(total), BARRIO)
head(ordenado)

#Reconicimiento de NA
desconocido <- NA
is.na(desconocido)
