allom <- read.csv('dataCursoR/Allometry.csv')
str(allom)
head(allom)
tail(allom)
summary(allom)

reg <- lm(llom$leafarea ~ allom$diameter)
reg <- lm(leafarea ~ diameter, data = allom)
summary(reg)
coefficients(reg)
# pay attention to the console
plot(reg)
hist(residuals(reg))

windows(12, 8)
plot(allom$leafarea ~ allom$diameter, pch = 19, col = as.factor(allom$species),
     ylab = expression('Leaf Area'~(m^2)), xlab = 'DBH (m)')
legend('topleft', legend = levels(allom$species), pch = 19,
       col = as.factor(levels(allom$species)), bty = 'n')

hist(allom$leafarea)
hist(log(allom$leafarea))


# para el próximo día
aovLeafArea <- aov(leafarea ~ species, data = allom)
aovLeafArea2 <- aov(log(leafarea) ~ species, data = allom)
summary(aovLeafArea)
summary(aovLeafArea2)

