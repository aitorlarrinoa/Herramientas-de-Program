###########################
## data.frames and dplyr ##
## Leonardo Hansa        ## 
## September 2021        ## 


library(dplyr)
library(readr)


df_mtcars <- read_csv("~/Desktop/Máster Ciencia de Datos/Herramientas de programación/data/mtcars.csv")
df_mtcars

df_mtcars %>% glimpse()# se lee de izq a der. Cogemos el data frame y le echamos un vistazo (operador pipe %>%)
#este pipe funciona gracias al paquete dplyr
glimpse(df_mtcars)

summary(df_mtcars)
class(df_mtcars)
df_mtcars$wt
class(df_mtcars$wt)

#para poder operar con tablas, en vez de trabajar con vectores, usamos el paquete dplyr. Lo hacemos de la siguiente forma:
iris %>% 
  select(Sepal.Length,Sepal.Width) %>%
  head()#encadenamos head para que no nos ensucie mucho la consola
#Tenemos así una tabla de una columna. select() selecciona columnas y nos devuelve una tabla

# %>% command + flecha arriba(shift) + m

#En lugar de escribir los nombres, puedo aporvechar que tienen palabras en común
iris %>% 
  select(contains("Sepal")) %>%
  head()

#También con el número de las columnas
df_mtcars %>% 
  select(1,3) %>%
  head()

#mutate me permite modificar la columna que quiera de la forma que quiero
df_mtcars %>% 
  mutate(wt_aux = wt * 1000) %>%
  select(wt,wt_aux)

df_mtcars %>% 
  mutate(wt = wt * 1000) %>% 
  select(wt)

df_mtcars <- df_mtcars %>% 
  mutate(wt = wt * 1000)

#elimino una columna que no me interesa
df_mtcars <- df_mtcars %>%
  select(-drat)

#si te cargas una columna que no quieres cargarte, tienes que volver a leer el csv.
# si todo el codigo desde arriba tiene sentido, podemos hacer command option b y ejecutamos desde donde estamos para arriba


df_mtcars %>% 
  mutate(wt = wt / 1000) %>% 
  select(wt)
                                                                                                           
mtcars %>% 
  mutate(vs = vs + 1) %>% 
  select(vs)

                                                                                                           
class(df_mtcars$vs)
df_mtcars %>%
  select(vs)

#queremos cambiar la columna de tipo numérico a tipo letra

mtcars %>%
  select(vs)


df_mtcars %>% 
  mutate(vs_aux = if_else(vs == 0, "V-shaped", "straight")) %>% #if vs == 0, etiquetamelo como V-shaped y sino ponmelo como straight
  select(vs, vs_aux)

#quiero cambiar ahora la cilindrada

mtcars %>% 
  mutate(cyl_aux = if_else(cyl == 4, "Tipo A", 
                           if_else(cyl == 6, "Tipo B","Tipo C"))) %>% 
  select(cyl,cyl_aux)

#esto es un poco pesado, otra forma de hacerlo es lo siguiente:
#option + command + arribay abajo, seleccionando algo, lo copio y lo muevo para arriba y para abajo

df_nuevo_con_lechuga <- mtcars %>% 
  mutate(#cyl_aux = if_else(cyl == 4, "Tipo A", 
                           #if_else(cyl == 6, "Tipo B","Tipo C"))
         lechuga = case_when(
           cyl == 4 ~ "Tipo A",
           cyl == 6 ~ "Tipo B",
           TRUE ~ "Tipo C" #en caso contrario, tipo c
         )) %>% 
  select(cyl,lechuga)

glimpse(df_nuevo_con_lechuga)




# Simulations -------------------------------------------------------------

runif(10)

set.seed(1234)# el set.seed me va a ayudar para que el siguiente número generado sea el mismo.
#Entonces si yo mañana vuelvo a ejecutar el código con 1234, entonces obtendré el mismo número.
runif(10) #10 valores random entre 0 y 1 (distribución uniforme)
runif(10,20,30) #10 valores random entre el 20 y el 30


set.seed(20)
lanzamientos <- sample(c("c","x"),size=10e3,replace=TRUE)
table(lanzamientos)


set.seed(45)
lanzamientos <- sample(c("c","x"),size=10e3,replace=TRUE)
table(lanzamientos)

#conclusión: con semillas diferentes obtengo un resultado parecido.

set.seed(1234)
results <- runif(10)

library(dplyr)
results
results<0.5
if_else(results < 0.5, "tails", "heads")

if_else(runif(20)<0.7,"entrenar","validar")

# Creating a data frame ---------------------------------------------------
                                                                                                           
number_of_stores <- 20

indices <- 1:number_of_stores # Index: 1, 2, 3, 4, ..., 20

set.seed(2718)

length_sim <- rnorm(number_of_stores, mean = 7, sd = 1.5)#número aleatorio de la distribuciónn normal
width_sim <- rnorm(number_of_stores, mean = 10, sd = 2.1)

mean(length_sim)

# For the customers, we assume that the average will be 50. 
# You'll learn what a Poisson distribution is later on
customers_daily <- rpois(number_of_stores, lambda = 50)
customers_daily
mean(customers_daily)
#rexp(20,50)# poner 50 o poner lambda = 50 es lo mismo

income_daily <- rnorm(number_of_stores, mean = 2000, sd = 100)


sample(2:12, size = 11)#puntuaciones posibles entre 2 y 12 pero sin reemplazamiento
puntuación_datos <- sample(2:12, size = 1e5,replace=TRUE)# al incluir con reemplazamiento, ya puedo poner 100.000 veces.
dado1 <- sample(c(1:6, size = 1e6, replace = TRUE))
dado2 <- sample(c(1:6, size = 1e6, replace = TRUE))

resultado_suma <- dado1 + dado2
table(resultado_suma)

colors <- sample(c("green", "blue", "red", "white"), 
size = number_of_stores, replace = TRUE)
                                                                                                           

#tible me permite crear data frames (tibbles)
df_inventado <- tibble(
ind = indices, 
long = length_sim, 
ancho = width_sim, 
clientes = customers_daily, 
euros = income_daily, 
col = colors
)

glimpse(df_inventado)
                                                                                                           