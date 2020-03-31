source('scriptsCursoR/basicFun.R')
# library(devtools)
install_bitbucket("remkoduursma/HIEv")
library(HIEv)

clim <- readTOA5('dataCursoR/CR6Series_Test.dat')
head(clim)
str(clim)

clim$DateTime <- as.character(clim$DateTime)
head(clim)
str(clim)
clim$DateTime <- lubridate::ymd_hms(clim$DateTime)
str(clim)

clim$day <- lubridate::mday(clim$DateTime)
clim$month <- lubridate::month(clim$DateTime, label = TRUE)
clim$year <- lubridate::year(clim$DateTime)
clim$Date <- as.Date(clim$DateTime)

clim2018 <- subset(clim, Date >= as.Date('2018-01-01') & Date <= as.Date('2018-12-31'))

clim2018$vpd <- calcVPD(RH = clim2018$RH_Avg, temp = clim20018$Temp_Avg)

climDay <- dplyr::summarise(dplyr::group_by(clim2018, Date),
                            Tmean = mean(Temp_Avg), Tmax = max(Temp_Avg), Tmin = min(Temp_Avg),
                            VPDmean = mean(vpd), VPDmax = max(vpd),
                            PPFDcum = sum(PPFD_Avg * 60 * 1e-06))
windows(12, 8)
plot(clim2018$Temp_Avg ~ clim2018$DateTime)
plot(clim2018$Temp_Avg ~ clim2018$DateTime, type = 'l')
plot(clim2018$Temp_Avg ~ clim2018$DateTime, type = 'l',
     xlab = 'Date', ylab=expression(italic(T)[air]~ ~(""^"o"*C)))

