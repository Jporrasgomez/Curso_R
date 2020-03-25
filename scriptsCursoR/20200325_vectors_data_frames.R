install.packages('dplyr')
library(dplyr)
installr::updateR()

vec <- rep(c('a', 'b', 'c'), 7)
vec1 <- seq(from = 0, to = 100, by = 10)
vec1 <- seq(0, 100, 10)
vec2 <- runif(25)
vec3 <- runif(25, 0, 100)
vec3 <- round(vec3)
vec4 <- c(NA, vec3, NA)

which(vec3 >= 43)
which(is.na(vec4))
which(!is.na(vec4))

mean(vec4)
mean(vec4, na.rm = T)
sd(vec4, na.rm = T)
length(vec4)
length(which(!is.na(vec4)))
s.err.vec <- sd(vec4, na.rm = T)/sqrt(length(which(!is.na(vec4))))

s.err.fun <- function(x){
  temp <- sd(x)/sqrt(length(x))
  return(temp)
}

s.err.fun.na <- function(x){
  temp <- sd(x, na.rm = T)/sqrt(length(which(!is.na(x))))
  return(temp)
}

allom <- read.csv('dataCursoR/Allometry.csv')
View(allom)
str(allom)
summary(allom)
levels(allom$species)