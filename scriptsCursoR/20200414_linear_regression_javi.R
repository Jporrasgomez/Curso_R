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

abline(reg, col = 'grey', lty = 4)
abline(a = coefficients(reg)[1], b = coefficients(reg)[2])

#Intento de meter leyenda con valores de R2 y p-value
#Consigo R2 mirando en internet jeje
# expression y ^2
legend("bottomright", bty="n", legend=paste("R2 =",
                                            format(summary(reg)$r.squared, digits=4)))

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


###COMO HACERLO CON UN LOOP. Plotear las tres 'abline' a la vez sobre el plot. 
#1) Cargamos el plot que hemos hecho antes. 
windows(12, 8)
plot(allom$leafarea ~ allom$diameter, pch = 19, col = as.factor(allom$species),
     ylab = expression('Leaf Area'~(m^2)), xlab = 'DBH (m)', par(mar = c(5,5,1.5,1.5)))

legend('topleft', legend = levels(allom$species), pch = 19,
       col = as.factor(levels(allom$species)), bty = 'n')

#2)Crear un objeto que defina la longitud del plot. En este caso, como queremos hacer un
#un loop que contenga 3 elementos, uno para cada especie, creamos un vector con estas 3 especies
sppName <- levels(allom$species)

#Para la función del plot, utilizamos 'lm', lo unico que le indicamos a R que utiliza 'data'
#como un subset de allom en el que se utilice de forma separada cada especie. Para este caso,
#no hace falta crear una lista ya que los elementos para hacer el loop son facilmente
#identificables y al ser factoriales podemos ordenarlos facilmente con 'levels'. 
myPal <- c('black', 'red', 'green')
for(i in 1:length(sppName)){
  r <- lm(leafarea ~ diameter, data = subset(allom, species == sppName[i]))
  abline(r, col = myPal[i], lty = 4)
}

# sacar p-valor. Para esto hay que conocer la estrutura de reg ya que R lo trata como una lista
#Podemos seleccionar elementos de esta lista. 
summary(reg)
str(reg[1])
str(reg)$coef
#1 forma
summary(reg)$coef[8]
#Otra forma
format(summary(reg)$coef[8], digits = 4)
'P < 0.001'

hist(allom$leafarea)
hist(log(allom$leafarea))

# para el próximo día
aovLeafArea <- aov(leafarea ~ species, data = allom)
aovLeafArea2 <- aov(log(leafarea) ~ species, data = allom)
summary(aovLeafArea)
summary(aovLeafArea2)

