source('scriptsCursoR/basicFun.R')
library(lubridate)
library(data.table)
source('scriptsCursoR/readTOA5.R')
clim <- readTOA5('dataCursoR/CR6Series_Test.dat')
head(clim)
str(clim)
tail(clim)
summary(clim)

climShort <- subset(clim, Date >= as.Date('2018-02-01') & Date <= as.Date('2018-02-28'))

# not sure if it works in mac
windows(12, 8)
plot(x = climShort$DateTime, y = climShort$Temp_Avg)
plot(climShort$Temp_Avg ~ climShort$DateTime, type = 'l')

climFeb <- subset(climShort, Date >= as.Date('2018-02-13') & Date <= as.Date('2018-02-23'))
par(mfrow = c(1, 2), mar = c(5, 5, 1.5, 1.5))
plot(climFeb$Temp_Avg ~ climFeb$DateTime, type = 'l', col = 'red',
     xlab = 'Date', ylab = expression(Temperature~(degree*C)), cex.lab = 1.4)
plot(climFeb$RH_Avg ~ climFeb$DateTime, type = 'l', col = 'blue',
     xlab = 'Date', ylab = 'RH (%)', cex.lab = 1.4)

# hacer una gráfica con el VPD en función de la temperature y/o de la humedad
