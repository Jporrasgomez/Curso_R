[]
()
vec <- runif(60)
vecSmall <- vec[12:36]
vecSmall[which(vecSmall <= 0.25)]

vecRound <- round(vecSmall, 1)

which(vecRound <= 0.2)
vecRound[which(vecRound <= 0.2)]

subset(vec, vec <= 0.25)

allom <- read.csv('dataCursoR/Allometry.csv')
# show first colum
# [filas, columnas]
allom[1, 1:3]
# mostrar todas columnas para las dos primeras filas
# dejo en blanco las columnas
allom[1:2, ]
# mostrar todas las filas de la primera columna
allom[, 1]
# ¿Cómo se llaman mis columnas?
names(allom)

misNombres <- names(allom)misNombresF <- as.factor(names(allom))

# cambiar el nombre a mis columnas
names(allom) <- c('espcie', 'diametro', 'altura', 'areafoliar', 'masarama')

# ¿cuántas filas hay?
str(allom)
nrow(allom)
# cambiar nombre de las filas
row.names(allom) <- c(64:126)

pipo <- subset(allom, species == 'PIPO')
pipo2 <- allom[which(allom$species == 'PIPO'), ]
