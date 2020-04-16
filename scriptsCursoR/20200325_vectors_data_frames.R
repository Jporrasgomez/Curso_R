#Como instalar un paquete: "dplyr" en este caso. Me da error no sé por qué!
install.packages('dplyr')
library(dplyr)

#Revisar actualizaciones de Rstudio
installr::updateR()

#Funcion rep() es para repetir 
vec <- rep(c('a', 'b', 'c'), 7)
vec1 <-rep(c(1,2,3),3)

#Funcion seq () es para dar un rango de numeros
vec2 <- seq(from=0, to=20, by=2)
vec3 <- seq(from = 0, to = 100, by = 10)
vec4 <- seq(0, 100, 10)

#Función runif() para dar numeros aleatorios entre 0 y 1 por defecto
vec5 <- runif(25)
#Función runif() para dar numeros aleatorios. "X numeros de Z a N" vec<-runif(X, Z, N)
vec6 <- runif(25, 0, 100)
#Utiizar función round() para redondear si no queremos decimales
vec7 <- round(vec3)

#Función which() Para conocer datos de nuestro vector. La respuesta indica la posición
vec8 <- c(NA, vec3, NA)
which(vec8 >= 43)
which(is.na(vec8))
#! quiere decir "no"
which(!is.na(vec8))

#Funciones para vectores con datos NA
mean(vec8)
mean(vec8, na.rm = T)
sd(vec4, na.rm = T)
length(vec8)
length(which(!is.na(vec8)))
#s.err.vec: standard error of vector
s.err.vec <- sd(vec8, na.rm = T)/sqrt(length(which(!is.na(vec8))))


#Crear tus propias funciones
nombrefuncion <- function(x){
  temp <- sd(x)/sqrt(length(x))
  return(temp)
}

s.err.fun.na<- function(x){
  temp<- sd(x, na.rm=T)/sqrt(length(which(!is.na(x))))
  return(temp)
}



s.err.fun.na(vec8)

#Abrir datos
allom <- read.csv('dataCursoR/Allometry.csv')
View(allom)
str(allom)
summary(allom)
levels(allom$species)


allom<-read.csv("dataCursoR/Allometry.csv")
View(allom)
str(allom)
summary(allom)
levels(allom$species)
levels(allom$diameter)

cereal<-read.csv('dataCursoR/cereals.csv')
View(cereal)
str(cereal)
levels(cereal$Cereal.name)
levels(cereal$Manufacturer)
summary(cereal)
