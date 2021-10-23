library(readr)

read_csv("~/Desktop/Máster Ciencia de Datos/Herramientas de programación/data/iris.csv")

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

read_cualquiera("~/Desktop/Máster Ciencia de Datos/Herramientas de programación/data/iris.csv")
read_cualquiera(1)


