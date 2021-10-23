

mean(c(1,2,3))

mean(c(1,NA,3), na.rm = TRUE)

otro_vector <- sample(c(1,NA,3), size = 10, replace = T)

mean(otro_vector, na.rm = T)


# vamos a hacer que siempre que le pida a mean algo con NA, no lo tenga en cuenta. Sin tener
# que escribir na.rm = TRUE

# lo que recibe la función se llama input y lo que hay entre llaves se llama cuerpo
#mi_media <- function(v) {
#  suma <- 0
#  if(is.na(v),
#     v <- na.omit(v),
#     for (i in 1:length(v)){
#    suma <- suma + v[i]
#  })
#  return(suma/length(v))
#}

mi_media <- function(v) {
  #print("Usuario, voy a quitar NAs")
  objeto_logico <- any(is.na(v)) # any: si al menos uno de sus elementos es TRUE
  if(objeto_logico){
    print("Hay NAs")
  } else {
    print("No hay NAs")
  } 
  calculo <- mean(v, na.rm = TRUE)
  #mensaje <- paste("Tu media es:", calculo)
  #print(mensaje)
  return(calculo)
}

objeto_guardado <- mi_media(c(1,2,NA))

