
cosa_369 <- c(3, 6, 9)
class(cosa_369)

cosa_abc <- c("a", "b", "c")
class(cosa_abc)

cosa_junta <- c(cosa_369, cosa_abc)
class(cosa_junta)

library(dplyr)

iris_setosa <- iris %>% 
  filter(Species == "setosa")

iris_versicolor <- iris %>% 
  filter(Species == "versicolor")

nrow(iris_setosa)
nrow(iris_versicolor)

cosa_rara <- c(iris_setosa, iris_versicolor)
cosa_rara$Species


# para juntar cosas de diferente clase, usaremos listas


lista <- list(cosa_369, cosa_abc)
length(lista)
class(lista)

# accedo al primer elemento de la lista
lista[[1]]
class(lista[[1]])

# segundo elemento del segundo elemento de lista
lista[[2]][2]

# hacemos una lista de data frames

lista_data_frames <- list(iris_setosa, iris_versicolor)

# podemos nombrar cada elemento de la lista
lista_nombrada <- list(df1 = iris_setosa, df2 = iris_versicolor)

# acedemos a los elementos 
lista_nombrada[[1]]
lista_nombrada[["df1"]]

lista_nombrada[["df1"]] %>% 
  summarise(median(Sepal.Length))

# vamos a crear tres data frames independientes y los juntamos en una lista.
# con map

casos_unicos <- unique(iris$Species)

library(purrr)

# creo una función que recibe como input uno de los tres casos de Species. Con ese caso,
# filtra las flas en iris y calcula la mediana de sepal.length

filtra_iris <- function(caso) {
  resultado <- iris %>% 
    filter(Species == caso) %>% 
    summarise(mediana = median(Sepal.Length))
  
  return(resultado)
} 
  

# luego aplico la función para los 3 casos disponibles

#lista_con_map <- map(casos_unicos, filtra_iris)

df_caso_setosa <- filtra_iris("setosa")
df_caso_versicolor <- filtra_iris("versicolor")
df_caso_virginica <- filtra_iris("virginica")



# descargarme el archivo de clase (30 septiembre 2021) porque me faltan cosas






