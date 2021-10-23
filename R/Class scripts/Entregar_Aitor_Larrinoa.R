# Cargamos las librerías
library(dplyr)
library(ggplot2)
library(readr)
library(janitor)
library(fivethirtyeight)

# 1 a)

# Echamos un vistazo a mtcars
glimpse(mtcars)

# Creamos un gráfico de puntos con las variables wt y mpg
ggplot(mtcars) +
  geom_point(aes(x = wt, y = mpg))

# 1 b)

# Añadimos un color a todos los puntos. Como todos llevan el mismo color
# la instrucción colour debe ir fuera de aes
ggplot(mtcars) +
  geom_point(aes(x = wt, y = mpg), colour = "red")

# 1 c)

# Pintamos ahora según la variable disp. Como los colores si dependen del 
# data frame, metemos la instrucción colour dentro de aes
ggplot(mtcars) +
  geom_point(aes(x = wt, y = mpg, colour = disp))

# 1 d)

# en vez de distinguirlos por colores, los distinguimos por tamaño en función 
# de la variable disp
ggplot(mtcars) +
  geom_point(aes(x = wt, y = mpg, size = disp))

# 2 a)

class(mtcars$cyl)

# La clase de la columna cyl es "numeric"

# 2 b)


mtcars %>% 
  distinct(cyl)
# Tenemos tres valores diferentes para la variable cyl

# 2 c)

# Hacemos un gráfico de puntos enfrentando mpg y cyl
ggplot(mtcars) +
  geom_point(aes(x = cyl, y = mpg))

# 2 d)

# Transformamos la variable cyl en factor.
mtcars <- mtcars %>%
  mutate(cyl = as.factor(cyl))

# Dibujamos ahora el gráfico de puntos enfrentando la nueva variable factor cyl y 
# la variable mpg
ggplot(mtcars) +
  geom_point(aes(x = cyl, y = mpg))

# 3 a)

# Echamos un vistazo a diamonds
glimpse(diamonds)

# 3 b)

# Hacemos un gráfico de puntos en el que enfrentamos price y carat. Esta última 
#indica el peso
ggplot(diamonds) +
  geom_point(aes(x = carat, y = price))

# 3 c)

# Modificamos el gráfico anterior haciendo más pequeños los puntos
ggplot(diamonds) +
  geom_point(aes(x = carat, y = price), size = 0.5)

# 3 d)

# Añadimos transparencia al gráfico anterior para poder verlo de una forma más clara
ggplot(diamonds) +
  geom_point(aes(x = carat, y = price), size = 0.5, alpha = 0.1)

# 3 e)

# Finalmente, acabamos el gráfico diibujándolo en función de clarity, con todas las 
# modificaciones anteriores
ggplot(diamonds) +
  geom_point(aes(x = carat, y = price, colour = clarity), size = 0.5, alpha = 0.4)

# 4 a)

# leemos el csv, quitamos los na y escribimos los nombres de las variables más claros
df_countries <- read_csv("data/countries_of_the_world.csv", locale = locale(decimal_mark = ",")) %>%
  clean_names() %>%
  na.omit()

# Echamos un vistazo al data frame
glimpse(df_countries)

# dibujamos un gráfico de puntos enfrentando las variables phones_per_1000 y literacy_percent
ggplot(df_countries) +
  geom_point(aes(x = literacy_percent, y = phones_per_1000))

# 4 b)

# Añadimos color al gráfico anterior en función de la región
ggplot(df_countries) +
  geom_point(aes(x = literacy_percent, y = phones_per_1000, colour = region))

# 4 c)

# Ponemos a todos los puntos el mismo color, es por ello que la instrucción colour va
# fuera del aes, y, además, dibujamos los puntos con diferentes tamaños en función de 
# la variable population
ggplot(df_countries) +
  geom_point(aes(x = agriculture, y = service, size = population), colour = "darkblue")


# ---------- LINE PLOTS ----------

# 1 a)

# Echamos un ojo a economics
glimpse(economics)

# dibujamos una serie temporal en la que enfrentamos unemploy a date
ggplot(economics) +
  geom_line(aes(x = date, y = unemploy))

# 1 b)

# añadimos una nueva variable unemploy_rate, la cual indicará el cociente de 
# unemploy y pop
economics_new <- economics %>%
  mutate(unemployment_rate = unemploy/pop)

# dibujamos ahora esta nueva variable frente a date en forma de serie temporal
ggplot(economics_new) +
  geom_line(aes(x = date, y = unemployment_rate))

# 1 c)

# lo hacemos directamente ahorrándonos la función mutate
ggplot(economics) +
  geom_line(aes(x = date, y = unemploy/pop))

# 2 a)

# Echamos un ojo a ChickWeight
glimpse(ChickWeight)

ggplot(ChickWeight) +
  geom_line(aes(x = Time, y = weight, group = Chick))

# 2 b)

ggplot(ChickWeight) +
  geom_line(aes(x = Time, y = weight, group = Chick, colour = Diet))


# ---------- COLUMN PLOTS ----------

# 1 

# Lo pintamos en dodge position. Esta debe ir fuera del aes porque no depende del
# data frame
df_countries %>%
  mutate(literacy_percent_90 = literacy_percent > 90) %>%
  ggplot() +
  geom_col(aes(x = literacy_percent_90, y = gdp_per_capita, fill = region,), position = "dodge")

# 2

# Echamos un ojo a biopics
glimpse(biopics)







