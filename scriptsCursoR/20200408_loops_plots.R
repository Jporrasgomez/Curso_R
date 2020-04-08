source('scriptsCursoR/basicFun.R')
library(lubridate)
library(data.table)
library(dplyr)
# library(doBy)
source('scriptsCursoR/readTOA5.R')
clim <- readTOA5('dataCursoR/CR6Series_Test.dat')

clim$vpd <- calcVPD(RH = clim$RH_Avg, temp = clim$Temp_Avg)

climDate <- summarise(group_by(clim, Date),
                      Tmax = max(Temp_Avg), Tmin = min(Temp_Avg), Tmean = mean(Temp_Avg))
climDate$YearMonth <- c(paste0(lubridate::year(climDate$Date), '-',
                               lubridate::month(climDate$Date)))

myLista <- list()
myLista[[1]] <- 'hola'
myLista[[2]] <- clim[1:20, ]
myLista[[3]] <- .5
myLista[[4]] <- calcVPD

levels(as.factor(climDate$YearMonth))
# myMonth <- levels(clim$YearMonth)
myMonth <- c(paste0(2017, '-', 4:12), paste0(2018, '-' , 1:3))

climList <- list()
for(i in 1:length(myMonth)){
  climList[[i]] <- as.data.frame(subset(climDate, YearMonth == myMonth[i]))
}

max(climDate$Tmax)
min(climDate$Tmin)
kk <- climList[[2]]
plot(kk$Tmean ~ kk$Date, type = 'l', xlab = '', ylab = expression(Temperature~(degree*C)),
     ylim = c(12, 26), main = kk$YearMonth[1])
lines(kk$Tmin ~ kk$Date, lty = 2)
lines(kk$Tmax ~ kk$Date, lty = 2)

windows(12, 8)
par(mfrow = c(3, 4))
for(i in 1:length(climList)){
  plot(climList[[i]][, 'Tmean'] ~ climList[[i]][, 'Date'], type = 'l', ylim = c(12, 24), xlab = '',
       ylab = expression(italic(T)~(degreee*C)),  main = climList[[i]][1, 'YearMonth'])
  lines(climList[[i]][, 'Tmax'] ~ climList[[i]][, 'Date'], lty = 2)
  lines(climList[[i]][, 'Tmin'] ~ climList[[i]][, 'Date'], lty = 2)
}
