########################
## Reading with readr ##
## Leonardo Hansa     ## 
## September 2021     ## 

# What is a csv file ------------------------------------------------------
#R.version para saber qué versión de R se tiene
library(readr)
iris_csv <- read_csv("~/Desktop/Máster Ciencia de Datos/Herramientas de programación/data/iris.csv")
#tilde/ y tabulador.
#si el csv está separado por coma, se usa read_csv
#si el csv está separado por punto y coma, se usa read_csv2
#si el csv está separado por tabulador, se usa read_tsv



#getwd() <- quiere decir que "cógeme el directorio de trabajo."

iberdrola_csv <- read_csv("~/Desktop/Máster Ciencia de Datos/Herramientas de programación/data/CO_2017.csv")
# Exercise.
# - How many columns are there on the tibble?
iberdrola_csv
length(iberdrola_csv)
# - How many rows?
length(iberdrola_csv[[1]])
# - What are the types of the columns? _Hint._ Use `class()`.
#for(i in 1:6) 
class(iberdrola_csv[[1,1]])
class(iberdrola_csv[[1,2]])
class(iberdrola_csv[[1,3]])
class(iberdrola_csv[[1,4]])
class(iberdrola_csv[[1,5]])
class(iberdrola_csv[[1,6]])




iris_csv <- read_csv2("~/Desktop/Máster Ciencia de Datos/Herramientas de programación/iris2.csv") 

#le voy a decir que esté en otro sitio distinto al escritorio
getwd()
#setwd() recibe una ruta a una carpeta:
#esta ruta siempre debe ser absoluta y siempre lleva a carpetas.
#setwd()
iris_tsv <- read_tsv("../data/sesiones/iris.tsv")

iris_nuevo <- read_delim(file = "../data/sesiones/iris.txt", delim = "|")

# Exercise. Read de file iris, with no extension.

read_csv("https://github.com/tidyverse/readr/raw/master/inst/extdata/mtcars.csv")

# Exercise. 
# - Check the classes of all the columns. 
# - ? iris; ? mtcars

read_csv("https://github.com/tidyverse/readr/raw/master/inst/extdata/mtcars.csv", col_types = "ninnnnnilii")
