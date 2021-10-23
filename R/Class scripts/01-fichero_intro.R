1+1
mean(1.4,6.7,4.3)
mean(c(1.4,6.7,4.3))
c(TRUE,FALSE,TRUE,FALSE)
alturas<-c(1,2,3,4)




my_data_frame <- data.frame(
  col1 = 1:4, 
  col2 = c("Category 1", "Category 2", "Category 3", "Category 4"), 
  col3 = c(3.4, -2.5, 10.1, -0.05), 
  col4 = c(T, F, F, T)
)

my_data_frame

class(my_data_frame)


iris

head(iris)

#Calculo la media de la anchura del sépalo
media <- mean(iris$Sepal.Length)
mayorSepalo <- iris$Sepal.Length > media
mayorSepalo

# Obtengo los valores que son mayor que la media
iris$Sepal.Length[mayorSepalo]

table(iris$Species)

