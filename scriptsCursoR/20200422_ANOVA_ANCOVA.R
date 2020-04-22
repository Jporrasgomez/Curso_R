allom <- read.csv('dataCursoR/Allometry.csv')

# check for normal distribution of data
hist(allom$leafarea)
# check transformed data
hist(log(allom$leafarea))

# ANOVA to check for OVERALL differences in leaf area among species
aovLeafArea2 <- aov(log(leafarea) ~ species, data = allom)
summary(aovLeafArea2)

# Post-hoc Tukey Honest Significant Difference's test
# all pair-wise comparision in one
TukeyHSD(aovLeafArea2)

# ANCOVAS Analysis of Covariance
ancovaLeafArea <- lm(leafarea ~ diameter * species, data = allom)
summary(ancovaLeafArea)
# this is equivalent to writing
summary(lm(leafarea ~ diameter + species + diameter:species, data = allom))
# OVERALL effects
anova(ancovaLeafArea)
