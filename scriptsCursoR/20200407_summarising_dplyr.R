source('scriptsCursoR/basicFun.R')
library(lubridate)
library(data.table)
library(dplyr)
# library(doBy)
source('scriptsCursoR/readTOA5.R')
clim <- readTOA5('dataCursoR/CR6Series_Test.dat')
head(clim)
str(clim)
tail(clim)
summary(clim)

#Añadir variable VPD a objeto clim
clim$vpd <- calcVPD(RH = clim$RH_Avg, temp = clim$Temp_Avg)

# crear variable mes con letras
#label=T es para que los meses se vean con nombres y no con numeros
clim$Month <- lubridate::month(clim$DateTime, label = T)
clim$Year <- lubridate::year(clim$DateTime)
clim$MonthYear <- as.factor(paste0(clim$Month, '-', clim$Year))


# forma antigua de hacer medias
# LENTO
kk <- doBy::summaryBy(Temp_Avg ~ MonthYear, data = clim, FUN = c(mean, s.err, sd, min, max, length))

# función útil
quantile()

# forma actualizada
library(dplyr)
climMonth <- summarise(group_by(clim, Month, Year),
                      Tmax = max(Temp_Avg, na.rm =T), Tmin = min(Temp_Avg), Tmean = mean(Temp_Avg),
                      VPDmean = mean(vpd), VPDmax = max(vpd),
                      PAR = sum(PPFD_Avg * 60 * 1e-06))
str(climMonth)
summary(climMonth)
View(climMonth)

#Ejercicio hecho por mí
climMonth2 <- summarise(group_by(clim, Month, Year),
                        Tmax = max(Temp_Avg, na.rm = T), Tmin = min(Temp_Avg, na.rm = T), 
                        Tmean = mean(Temp_Avg, na.rm = T), RHmax = max(RH_Avg, na.rm = T),
                        RHmin = min(RH_Avg, na.rm = T), RHmean = mean(RH_Avg, na.rm = T))
str(climMonth2)
summary(climMonth2)
