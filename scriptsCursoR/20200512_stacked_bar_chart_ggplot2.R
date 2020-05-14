javi <- read.csv('dataCursoR/javi.csv')
javi$Factor <- as.factor(javi$Factor)
library(forcats)
library(ggplot2)
library(dplyr)

windows(10, 8)
# create a plot using ggplot2
javiPlot <- ggplot(javi, aes(x = Factor, y = Fw)) +
  geom_bar(stat = 'identity')

# plot in decreasing/increasing order
javi %>%
  mutate(Factor = fct_reorder(Factor, Fw)) %>%
  ggplot( aes(x = Factor, y = Fw)) +
  geom_bar(stat="identity", width=.4)

# flip graph and customize label
javi %>%
  mutate(Factor = fct_reorder(Factor, Fw)) %>%
  ggplot( aes(x = Factor, y = Fw)) +
  geom_bar(stat="identity", width=.4) +
  coord_flip() +
  xlab("") +
  ylab("") +
  theme_bw()

# reshape Javi's data-frame

names(javi)[2:(ncol(javi)-1)] <- paste0(1:3, names(javi)[2:(ncol(javi)-1)])
javiLong <- reshape(javi[, 1:(ncol(javi)-1)], direction ='long',
                    idvar = 'Factor', varying = c('1Tw', '2Gw', '3Bw'),
                    v.names = 'value')
javiLong$var_cat <- ifelse(javiLong$time == 1, 'Tw', 'Bw')
javiLong$var_cat <- ifelse(javiLong$time == 2, 'Gw', javiLong$var_cat)

javiLong <- left_join(javiLong, javi[, c('Factor', 'Fw')], by = 'Factor')
javiLong$meanFw <- mean(javiLong[, 'Fw'])

# stacked bar chart with line for mean value of Fw

javiLong %>%
  mutate(Factor = fct_reorder(Factor, Fw)) %>%
  ggplot( aes(x = Factor, y = value, fill = var_cat)) +
  geom_bar(stat="identity", width=.4) +
  coord_flip() +
  xlab("") +
  ylab("") +
  theme_bw() +
  geom_line(aes(x = as.numeric(Factor), y = meanFw))
