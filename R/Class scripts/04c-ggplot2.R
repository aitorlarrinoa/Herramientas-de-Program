library(ggplot2)

# Estoy visualiando 4 columnas de la tabla a la vez
ggplot(mtcars, aes(x = wt, y = mpg, shape = as.factor(am), color = as.factor(cyl))) +
  geom_point()

# Otra forma de visualizar 4 columnas es la siguiente:
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() + 
  facet_grid(am ~ .)# facet grid me crea una malla en la que le indico que quiero que me pinte
# tantos gráficos como tipos de cambio hay (manual, automático). Pongo am por filas y por columnas nada

# añado en las columnas el tipo de cilindrada
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() + 
  facet_grid(am ~ cyl)
# Separamos la información en función de si es automático o no y la cilindrada

# si tenemos una única variable podemos hacer lo siguiente
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() + 
  facet_wrap(~ cyl)

library(dplyr)
library(tidyr)

glimpse(msleep)
msleep


# Hemos cogido el data frame y lo ponemos en modo largo.
mamsleep <- msleep %>% 
  select(vore, name, sleep_total, sleep_rem) %>% 
  pivot_longer(cols = one_of(c("sleep_total", "sleep_rem")), names_to = "sleep", values_to = "time")

glimpse(mamsleep)

ggplot(mamsleep, aes(x = time, y = name, col = sleep)) +
  geom_point() +
  facet_grid(vore ~ .)


# no quiero tener todos los animales en cada grupo. Para ello añado que las escalas de cada punto
# sean distintos
ggplot(mamsleep, aes(x = time, y = name, col = sleep )) +
  geom_point() +
  facet_grid(vore ~ ., scales = "free_y", space = "free_y") + 
  theme(legend.position = "bottom")
