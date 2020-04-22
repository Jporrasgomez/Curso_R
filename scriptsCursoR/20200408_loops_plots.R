source('scriptsCursoR/basicFun.R')
library(lubridate)
library(data.table)
library(dplyr)
# library(doBy)
source('scriptsCursoR/readTOA5.R')
clim <- readTOA5('dataCursoR/CR6Series_Test.dat')

#Crear una Lista!
myLista <- list()
myLista[[1]] <- 'hola'
myLista[[2]] <- clim[1:20, ]
myLista[[3]] <- .5
myLista[[4]] <- calcVPD

#Se puede ver cada elemento de la lista
View(myLista[[1]])
summary (myLista[[2]])
head (myLista[[2]])
View(myLista[[2]])

#se puede plotear los elementos de la lista que lo permitan
plot(myLista[[2]]$Temp_Avg~myLista[[2]]$DateTime, type ='l', col='red', ylab='meanTemp'
     ,xlab='minutos 3 a.m.')

#Añadimos la variabla VPD a clim
clim$vpd <- calcVPD(RH = clim$RH_Avg, temp = clim$Temp_Avg)

#Creamos el objeto 'climDate'con la Tmax, Tmin y Tmean para cada día de clim. Este objeto tiene
#320 observaciones, los días que hay medidos. 
climDate <- summarise(group_by(clim, Date),
                      Tmax = max(Temp_Avg), Tmin = min(Temp_Avg), Tmean = mean(Temp_Avg))
#Añadimos la variable 'YearMonth' al objeto 'climDate'. Para ello extraemos de la variable
#'Date' (dentro de 'climDate') el año y el mes con el paquete lubridate. 
#con la función paste0, juntamos los dos elementos. 

climDate$YearMonth <- c(paste0(lubridate::year(climDate$Date), '-',
                               lubridate::month(climDate$Date)))


#La variable 'YearMonth'es identidficada por R como character (str(climDate))
#Si queremos ver como R ordena estw variable tenemos que usar 'as.factor'
levels(as.factor(climDate$YearMonth))
#Vemos que se ordena como 2017-10, 2017-11... y así. Hay que poner el primer mes (2017-02)
#el primero. No tengo claro que hacemos aquí.¿como sabe R que los datos los tiene que coger
#de climDate si no se le indica en ningún momento? Preguntar a Teresa
myMonth <- c(paste0(2017, '-', 4:12), paste0(2018, '-' , 1:3))

#LOOPs: Creamos la lista 'climList' asignando unos elementos automáticamente. Para ello utilizamos
#la función 'for' Le decimos que para cada elemento 'i' de la lista, con una longitud x (en este
#caso la longitud es el numero de meses de clim, que hemos creado antes en 'myMonth'). Luego
#le decimos a R que queremos que sea cada elemento 'i'. En este caso, queremos que cada elemento
#sea un subset de la variable 'YearMonth' del objeto ' climDate' para cada elemento del objeto
#'myMonth'. 
climList <- list()
for(i in 1:length(myMonth)){
  climList[[i]] <- as.data.frame(subset(climDate, YearMonth == myMonth[i]))
}


#Creamos un objeto que sea el elemento numero 2 de la lista 'climList'
kk <- climList[[2]]
#Ploteamos este objeto (elemento 2 de 'climList')
plot(kk$Tmean ~ kk$Date, type = 'l', xlab = '', ylab = expression(Temperature~(degree*C)),
     ylim = c(12, 26), main = kk$YearMonth[1])
#Añadimos 2 líneas al gráfico, una de las Tmin y otra de las tmax. 'lty' means 'linetype'
#y el numero 2 se refiere a punteado. 
lines(kk$Tmin ~ kk$Date, lty = 2)
lines(kk$Tmax ~ kk$Date, lty = 2)

#Podemos plotear todos los elementos de una lista a la vez con un loop de plots. Para verlos
#todos a la vez le decimos a R que nos muestre los gráficos en 3 filas y 4 columnas con la 
#función par. Para elegir 'x' e 'y' dentro de los elementos de una lista no usamos $, si no
#unos corchetes: climList[[i]][,'Tmean']~climList[[i]][,'Date'] lo que quiere decir que para 
#todos los elementos de la lista 'climList' coja Tmean como 'Y' y 'Date' como 'X'.  
par(mfrow = c(3, 4))
for(i in 1:length(climList)){
  plot(climList[[i]][, 'Tmean'] ~ climList[[i]][, 'Date'], type = 'l', ylim = c(12, 24), xlab = '',
       ylab = expression(italic(T)~(degree*C)),  main = climList[[i]][1, 'YearMonth'])
  lines(climList[[i]][, 'Tmax'] ~ climList[[i]][, 'Date'], lty = 2)
  lines(climList[[i]][, 'Tmin'] ~ climList[[i]][, 'Date'], lty = 2)
}



#######EJERCICIO POR MI CUENTA
#Intentar hacer lo mismo pero en vez de la temperatura, con RH. (limpiar environment)
#OBJETIVO: Ver la media de RH para cada mes en un gráfico. 

#1) Arupamos los rangos que queremos incluir en nuestra lista. En este caso, queremos la media 
#de RH para cada día. Eso son 320 observaciones para 2 variables: 'Date' y 'RHmean'. 
climRH <- summarise(group_by(clim, Date),
                    RHmean = mean(RH_Avg))

#2) Añadir la variable 'YearMonth' a climRH con lubridate. Fragementamos la variable 'Date' y
#extraemos 'year' y 'month' para unirlos en la nueva variable
climRH$YearMonth <- c(paste0(lubridate::year(climRH$Date), '-',
                             lubridate::month(climRH$Date)))

#3)Compronbar como R ordena por defecto 'climRH' con la variable 'YearMonth'
levels(as.factor(climRH$YearMonth))
#Respuesta R:"2017-10" "2017-11" "2017-12" "2017-4"  "2017-5"  "2017-6"  "2017-7" 
#"2017-8"  "2017-9" "2018-1"  "2018-2"  "2018-3" 
#Hay que ordenarlos de tal forma que "2017-4" sea el primer mes, porque esta es la forma de
#definir la longitud de la lista que se va a hacer. Podríamos utilizar esto, pero entonces
#los gráficos saldrían igualmente desordenados y no sería visualmente entendible.

#4) Como R ordena mal con 'YearMonth', creamos un vector que defina la longitud de la lista. 
#Creamos un vector. 
myMonth2 <- c(paste0(2017, '-', 4:12), paste0(2018, '-', 1:3))

#5) Crear una LISTA con un LOOP para definir automáticamente los elementos. 
climRHlist <- list()
for(i in 1:length(myMonth2)){
  climRHlist[[i]] <- as.data.frame(subset(climRH, YearMonth == myMonth2[i]))
}

#6) Plotear la lista con otro LOOP. 
par(mfrow = c(3,4))
for(i in 1:length(climRHlist)){
  plot(climRHlist[[i]][,'RHmean'] ~ climRHlist[[i]][,'Date'], type ='l',  ylab = 'RH(%)' 
       , xlab = 'date' , main = climRHlist[[i]][1, 'YearMonth'])
}

#SI sale :D     
