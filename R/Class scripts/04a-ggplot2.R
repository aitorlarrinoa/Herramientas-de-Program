###########################
## ggplot2 and dataviz   ##
## Leonardo Hansa        ## 
## September 2021        ## 

## First steps into dataviz ---------------------------

plot(sample(seq(0, 1, by = 0.01)))
#plot(seq(0, 1, by = 0.01))
plot(iris)

library(ggplot2)

P <- ggplot()
class(P)

P

# - Data
# - The axis
# - Aesthetics
# - Labelling
# - Distribution on the board
# - ...


# Scatter plots -----------------------------------------------------------
ggplot(iris) 

# a ggplot hay que decirle que queremos pintar. Por ejemplo, le decimos que nos dibuje una capa de puntos

ggplot(iris) + 
  geom_point(aes(x = Sepal.Length, y = Sepal.Width))
# hay que inidcarle qué columnas generan el eje x y el eje y. En este caso Sepal.Length y Sepal.Width
# el aes es una función que nos permite definir cuales son los conjuntos estéticos del gráfico.

ggplot(iris) + 
  geom_point(aes(x = Sepal.Length, y = Sepal.Width, colour = Species))

# añadimos colour para colorear por grupos.

# se puede separar también por forma.
ggplot(iris) + 
  geom_point(aes(x = Sepal.Length, y = Sepal.Width, shape = Species))

# ggplot(iris) + 
#   geom_point(aes(x = Sepal.Length, y = Sepal.Width), colour = Species)
# Error in layer(data = data, mapping = mapping, stat = stat, geom = GeomPoint, : object 'Species' not found
#```


# quiero que esté todo del color y como no depende del data frame, lo pongo fuera del aes.
ggplot(iris) + 
  geom_point(aes(x = Sepal.Length, y = Sepal.Width), colour = "darkblue")


# cambiamos lo gordos que puedan ser los puntos
ggplot(iris) + 
  geom_point(aes(x = Sepal.Length, y = Sepal.Width, colour = Species), size = 4)


# podemos poner opacidad para cuando se acumulan muchos puntos en un lugar
ggplot(iris) + 
  geom_point(aes(x = Sepal.Length, y = Sepal.Width, colour = Species), size = 4, alpha = 0.4)

# Column plots ------------------------------------------------------------
# gráficos de columnas
library(dplyr)

# creamos un nuevo data frame con dplyr. Calculamos las medias de petal length y petal width para cada especie
iris2plot <- iris %>% 
  group_by(Species) %>% 
  summarise(avg_petal_length = mean(Petal.Length), 
            avg_petal_width = mean(Petal.Width))

iris2plot

# creamos así el gráfico de columnas
ggplot(iris2plot) + 
  geom_col(aes(x = Species, y = avg_petal_length))


ggplot(iris2plot) + 
  geom_col(aes(x = Species, y = avg_petal_length), 
           fill = "#F47C00") # fill es otra forma de poner colores

# si pongo colour, se me pinta el borde.
ggplot(iris2plot) + 
  geom_col(aes(x = Species, y = avg_petal_length), 
           colour = "#F47C00")

#colour me pinta los bordes de las cosas y fill me pinta el relleno.

ggplot(iris2plot) + 
  geom_col(aes(x = Species, y = avg_petal_length), 
           colour = "#F47C00", fill = "White")

# Line plots --------------------------------------------------------------
glimpse(economics)
class(economics$date) # es de clase Date

# puedo sumar cosas a fechas

as.Date("2021-09-23") + 1


# Notice that you can include the aes() functions inside geom_line() or ggplot()
ggplot(economics, aes(date, unemploy)) + 
  geom_line()

ggplot(economics, aes(x = date, y = unemploy)) + 
  geom_line()

ggplot(economics, aes(x = date, y = unemploy)) + 
  geom_line(color = "red")

ggplot(economics, aes(x = date, y = unemploy)) + 
  geom_line(color = "red", size = 2)


# hmmm
# añado una serie más
ggplot(economics) + 
  geom_line(aes(x = date, y = unemploy)) + 
  geom_line(aes(x = date, y = uempmed))

# como la escala entre ambas es muy diferentes, los escalo igual.
# lo pongo en todo en porcentaje, escalado a 1.

scaled_economics <- economics %>% 
  select(date, unemploy, uempmed) %>% 
  mutate(unemploy = unemploy / max(unemploy), 
         uempmed = uempmed / max(uempmed))

# como los dos comparten el mismo eje x, lo pongo en el data frmae y en los geom_line solo
# esceibo las y

ggplot(scaled_economics, aes(x = date)) + 
  geom_line(aes(y = unemploy)) + 
  geom_line(aes(y = uempmed))

glimpse(economics_long)

# quiero ver el dato de desempleados el 1 de enero de 1980
economics %>% 
  select(date, unemploy) %>% 
  filter(date == as.Date("1980-01-01"))

economics_long %>% 
  select(date, variable, value) %>% 
  filter(variable == "unemploy", date == "1980-01-01")


ggplot(economics_long) +
  geom_line(aes(x = date, y = value01))

ggplot(economics_long) +
  geom_line(aes(x = date, y = value01, group = variable))

ggplot(economics_long) +
  geom_line(aes(x = date, y = value01, colour = variable))

