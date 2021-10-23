# ejercicio propuesto en clase

pares <- function (n) {
  #return(n%%2 == 0)
  if(n%%2 == 0) {
    mensaje <- paste(n, "es par")
  } else {
    mensaje <- paste(n, "es impar")
  }
  return(mensaje)
}



# lo hacemos de dos formas:
# forma 1
lapply(1:20, pares)

# forma 2
for(i in 1:20) {
  print(pares(i))
}

# si yo en una función no pongo return, esta me devuelve el último cálculo que ha hecho. Las cosas que pongo 
# dentro de una función (dentro de las llaves) no tiene nada que ver con lo que esribo dentro.

# primero se busca en el entorno local(dentro de la función), sino luego se busca en el entorno global.


# ejercicio 13 (sección 5)

compound <- function(amount, interest, periods) {
  return(amount*(1 + interest)^(periods))
}

# a)

compound(1000, 0.07, 1)

# b)

compound(1000, 0.07, 10)

# c) 

compound(1000, 0.01, 4)

# command shift r me hace como secciones

# ejercicio 3 con la misma función

compund2 <- function (periods) {
  return(1*(1 + 1/periods)^(periods))
}


sapply(c(1,2,4,12,365), compund2)

for (i in c(1,2,4,12,365)) {
  print(compund2(i))
}

library(purrr)
laply()
# en purrr tenemos la familia map en vez de la familia apply
# la familia map me va a permitir controlar el resultado que yo quiero obtener
# en este caso un vector de números dobles.
map_dbl(c(1,2,4,12,365), compund2)


