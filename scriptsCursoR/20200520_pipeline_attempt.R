library(dplyr)

metaJavi <- read.csv("dataCursoR/metadata.csv", sep = ';')
metaJavi %<%
  summarise(group_by(, Factor, Review_label),
            NS = mean(N_studies)) %>%
  summarise(group_by(, ))

