# script básico
# ¿Para qué sirve R?
# R como calculadora
2 * 3
2^3
2E02
2E-03
round(2.5678)
floor(2.4)
ceiling(2.4)

valor <- 5
constante <- 0.6
rm(valor)

# trabajar con vectores
# crear un vector
vector1 <- c(4, 1, 6, 8, 23, 5, 6, 8, 8, 3)
# operar con vectores
mean(vector1)
sd(vector1)
sd(vector1)/sqrt(length(vector1))
vector2 <- c(4, 1, 6, 8, 23, 5, 6, 8, 8, 3, NA)
mean(vector2, na.rm = TRUE)
