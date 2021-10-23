library(readr)

# como está delimitado por espacios, lo que hago es leerlo con read_delim y explicarle qué
# delimitador se usa

anscombe <- read_delim("~/Desktop/Máster Ciencia de Datos/Herramientas de programación/data/anscombe", delim=" ")

# ejercicio 9 (babynames)
  
babynames <- read_delim("~/Desktop/Máster Ciencia de Datos/Herramientas de programación/data/babynames")

babynames


# ejercicio 10

nombres_random <- c("Mariyanna", "Lamiah", "Shandal","Rynda", "Kcee", "Camia","Isaiyah", "Barbare", "Braxon","Kailly")
length(nombres_random)

filtra_babynames <- function(bebes) {
  babynames %>% 
    filter(name == bebes) %>% 
    summary()
} 


encuentra_babies <- map(nombres_random, filtra_babynames)

length(encuentra_babies)
class(encuentra_babies)

class(encuentra_babies[[2]])

library(ggplot2)

año_filtrado <- function(año, logical) {
  baby_año <- babynames %>% 
    filter(year == año)
  if (logical) {
    ggplot(baby_año) + 
    geom_histogram(aes(x = n))
  } else{
    ggplot(baby_año) + 
    geom_boxplot(aes(y = n))
  }
  
}

año_filtrado(1980, TRUE)



