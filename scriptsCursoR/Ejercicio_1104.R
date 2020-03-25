#Ejercicio 1.10.4
one<-1
two<-2
vector1<-c(one,two)
remove(myvec,x,y,z)
vector2<-c("one","two")
vector3 <- c("one", "two", "three", "four", "five", "seven")
vec.var<-var(c(1, 3, 5, 3, 5, 1))
vec.mean <- mean(c(1, 3, 5, 3, 5, 1))
vec.min <- min(c(1, 3, 5, 3, 5, 1))
vector4 <- c('a', 'b', 'f', 'g')
vector2

#Ejercicio 1.10.5
rm(list=ls())
vec2<-c(2,3,4,5,6)
cumsum(vec2)
rev(cumsum(vec2))
lcil<-c(2.1, 3.4, 2.5, 2.7, 2.9)
dcil<-c(0.3, 0.5, 0.6, 0.9, 1.1)
rm(diametercylinders, lengtcylinders)
rm(lc)
volcil<-c((pi*(dcil/2)^2)*lcil)
sd(volcil)
#Ejercicio 1.10.6
install.packages("car")
library(car)
?densityPlot
example("densityPlot")
