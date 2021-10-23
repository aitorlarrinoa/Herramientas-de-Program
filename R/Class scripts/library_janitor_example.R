iris

colnames(iris)
rownames(iris)
row.names(mtcars)


names(iris)

#quiero cambiar manualmente el nombre de las columnas de iris

iris_auxiliar <- iris

names(iris_auxiliar) <- c("sepal_length", "sepal_width", "petal_length", "petal_width", "species")

iris_auxiliar

# eso es muy engorroso, hay una mejor opricón con el paquete janitor.
library(janitor)

clean_names(iris)
