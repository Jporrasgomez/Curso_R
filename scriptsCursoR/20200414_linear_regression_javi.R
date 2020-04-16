#REGRESION LINEAL. 
allom <- read.csv('dataCursoR/Allometry.csv')
str(allom)
head(allom)
tail(allom)
summary(allom)

#Lo que hacemos es comprobar si 2 variables se ajustan a un modelo de distribución lineal o
#regresión lineal. En este caso cogemos las variales "area foliar" y "diámetro". Se puede pedir 
#a R de estas 2 formas: 
reg <- lm(allom$leafarea ~ allom$diameter)
reg <- lm(leafarea ~ diameter, data = allom)


#HAY 3 FORMAS DE VER SI NUESTRA REGRESIÓN ES SÓLIDA:'R2', 'p-value' y 'Residual values'.

#R2 determina la intensidad de la regresión lineal,mientras que p-value determina su significancia. 
#R2, p-value y pendiente e intercepto (la 2º solo muestra pendiente e intercepto)
summary(reg)
coefficients(reg)

#VALORES RESIDUALES. Los residuales son los valores que hay entre los puntos observados
#y el modelo lineal. Cuanto mayor sean estos residuales, menos se ajustan nuestros datos al MRL. 
# pay attention to the console. el 2º grafico es el más visual de entender. Cuanto más agrupados
#en torno a 0 estén los residual values, más cerca del MRL están nuestras datos observados. 
plot(reg)
hist(residuals(reg))

#PLOTEAR UN MRL. 
#1) Ploteamos normalmente los datos observados de las dos variables. 
windows(12, 8)
plot(allom$leafarea ~ allom$diameter, pch = 19, col = as.factor(allom$species),
     ylab = expression('Leaf Area'~(m^2)), xlab = 'DBH (m)', par(mar = c(5,5,1.5,1.5)))

legend('topleft', legend = levels(allom$species), pch = 19,
       col = as.factor(levels(allom$species)), bty = 'n')

#Intento de incluir el modelo de regresión en la gráfica con 'abline'
abline(a = -51.3245, b = 4.6333, col='grey', lty=4)
#Intento de meter leyenda con valores de R2 y p-value
#Consigo R2 mirando en internet jeje
legend("bottomright", bty="n", legend=paste("R2 =", format(summary(reg)$adj.r.squared, digits=4)))
 
#Intentar introducir un MRL para cada especie con el color correspondiente. 
#Creo que hay que hacer 3 regresiones diferenciadas para sacar los datos. 
levels(allom$species)
#3 especies: PIMO, PIPO y PSME. Subset de 'allom' para cada especie. 
PIPO <- subset(allom, species == 'PIPO')
PIMO <- subset(allom, species == "PIMO")
PSME <- subset(allom, species == 'PSME')

#Regresión para cada grupo de datos
regPIPO <- lm(leafarea ~ diameter, data = PIPO)
regPIMO <- lm(leafarea ~ diameter, data = PIMO)
regPSME <- lm(leafarea ~ diameter, data = PSME)

#Summary para cada regSPECIES
summary(regPIPO)
summary(regPIMO)
summary(regPSME)

#COPIO PLOT DE GRÁFICO PRINCIPAL. 
plot(allom$leafarea ~ allom$diameter, pch = 19, col = as.factor(allom$species),
     ylab = expression('Leaf Area'~(m^2)), xlab = 'DBH (m)',par(mar = c(5,5,1.5,1.5)))

legend('topleft', legend = levels(allom$species), pch = 19,
       col = as.factor(levels(allom$species)), bty = 'n')

#METER ABLINES
ablinePIPO <- abline(-64.5259 , 4.2442, lty = 4, col = 'red')
ablinePIMO <- abline(-31.8764 , 4.4921, lty = 4, col = 'black')
ablinePSME <- abline(-60.5421 , 5.3715, lty = 4, col = 'green')

#SALE BIEN!! Me faltaría saber como añadir los datos de R2 y p-value a cada linea


hist(allom$leafarea)
hist(log(allom$leafarea))

# para el próximo día
aovLeafArea <- aov(leafarea ~ species, data = allom)
aovLeafArea2 <- aov(log(leafarea) ~ species, data = allom)
summary(aovLeafArea)
summary(aovLeafArea2)

