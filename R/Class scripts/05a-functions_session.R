library(readr)
library(dplyr)
library(janitor)

# Lectura -----------------------------------------------------------------

df_cartera <- read_csv2("~/Desktop/Máster Ciencia de Datos/Herramientas de programación/data/warren_portfolio.datafile")
df_cartera <- clean_names(df_cartera)
df_evolution <- read_csv("~/Desktop/Máster Ciencia de Datos/Herramientas de programación/data/value_evolution")
df_evolution <- clean_names(df_evolution)

df_cartera

# Función información -----------------------------------------------------

show_info <- function(ticker){
  df_filtrado <- df_cartera %>% 
    filter(symbol == ticker)
  
  empresa <- df_filtrado$company
  acciones <- df_filtrado$shares
  
  texto_generado <- paste0("Warren Buffett tiene ", acciones, " de ", empresa)
  
  return(texto_generado)
  
}

df_cartera$company

# función para saber si una compañía está en el data frame
compañia_in <- function(compañia){
  return(as.character(compañia) %in% df_cartera$company)
  #if (compañia %in% df_cartera$company){
  #  return(TRUE)
  #}
  #  return(FALSE)
}

compañia_in(santander)


# función para saber si Warren tiene acciones en una compañía y cuantas tiene
compañia_acciones <- function(compañia){
  if (compañia_in(compañia)){
    acciones <- df_cartera %>% 
      filter(company == compañia)
    return(paste("Warren Buffet tiene", as.numeric(acciones$shares), "acciones de", compañia))
  }
  return(paste("Warren Buffet no tiene acciones de", compañia))
}

compañia_acciones("Apple")

# ------- bucles con R base. FAMILIA DE FUNCIONES APPLY -----

empresas_seleccionadas <- c("Facebook", "Apple", "Evergrande", "Inditex", "Bank of America", "Coca Cola", "Mercadona")

#lapply aplica lo que está a la derecha a lo que está a la izq, elemento a elemento. (nos devuelve una lista)
lapply(empresas_seleccionadas, compañia_acciones)

objeto_raro_guardado <- lapply(empresas_seleccionadas, compañia_acciones)
class(objeto_raro_guardado)

#sapply nos devuelve un vector. 
sapply(empresas_seleccionadas, compañia_acciones)

# la función de antes.
read_cualquiera <- function(ruta){
  if (! is.character(ruta)) {
    stop("El input no es un character")
  }
  datos <- read_csv(ruta)
  if (ncol(datos) == 1) {
    datos2 <- read_csv2(ruta)
    if (ncol(datos2) == 1) {
      return(read_tsv(ruta))
    } else {
      return (datos2)
    }
  } else {
    return(datos)
  }
}

# aplico el sapply a diferentes rutas
rutas <- c("~/Desktop/Máster Ciencia de Datos/Herramientas de programación/data/warren_portfolio.datafile", "~/Desktop/Máster Ciencia de Datos/Herramientas de programación/data/value_evolution")
sapply(rutas, read_cualquiera)

# -- bucles for -- 

#importante poner el print porque sino no voy a ver nada
for (empresa in empresas_seleccionadas) {
  print(compañia_acciones(empresa))
}


# ejercicio para el miercoles. Para los números del 1 al 20 hay que comprobar si el número
# es par o impar. Hacer una función y luego aprovecharla para un apply o un for





df_cartera$symbol

show_info("AAPL")
show_info("KO")

# Algo raro
show_info("GOOGL")

# Añadimos if else
show_info2 <- function(ticker){
  
  if(!ticker %in% df_cartera$symbol){
    return("Warren Buffet no tiene este valor en su cartera")
  } else {
    df_filtrado <- df_cartera %>% 
      filter(symbol == ticker)
    
    empresa <- df_filtrado$company
    acciones <- df_filtrado$shares
    
    texto_generado <- paste0("Warren Buffett tiene ", acciones, " de ", empresa)
    
    return(texto_generado)
  }
  
}

show_info2("GOOGL")


# Ejercicios ---------------------------------------------------------------
#' 1. Función que muestre el número de acciones o el porcentaje que supone de la cartera. 
#' Uno de los argumentos de entrada será el símbolo y otro será el nombre de la columna
#' buscada. 
#' 
#' 2. Función que reciba nombre de compañía y mes del año y genere un data frame solo con esos
#' datos, a partir del csv de evolución. 
#' 
#' 3. Función que reciba un data frame (como el generado con la función anterior) y calcule la 
#' media y la mediana de las acciones. 
#' 
#' 4. Función que reciba nombre de compañía y mes del año y haga de golpe lo que hacen las funciones
#' de los ejercicios 2 y 3.



# if_else() ---------------------------------------------------------------

# if_else dentro del data frame
library(lubridate)
df_evolution %>% 
  mutate(mes = month(date),
         semestre = if_else(mes %in% 1:6, "H1", "H2")) %>% 
  group_by(company, semestre) %>% 
  summarise(mean(close_value))
