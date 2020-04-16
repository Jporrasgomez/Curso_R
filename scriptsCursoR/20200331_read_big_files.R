source('scriptsCursoR/basicFun.R')
install.packages("lubridate")
library(lubridate)
source('scriptsCursoR/readTOA5.R')
source("scriptsCursoR/readTOA5.R")
clim <- readTOA5('dataCursoR/CR6Series_Test.dat')
head(clim)
str(clim)
tail(clim)
summary(clim)

climShort <- subset(clim, Date >= as.Date('2018-02-01') & Date <= as.Date('2018-02-28'))


windows(12,8)
