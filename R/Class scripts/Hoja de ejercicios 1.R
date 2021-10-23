#---------------------------%%%%%---------------------------------
#---------------------------%%%%%---------------------------------
#-------------------------SECCIÓN 1-------------------------------
#---------------------------%%%%%---------------------------------
#---------------------------%%%%%---------------------------------

library(dplyr)

#EJERCICIO 1: Count the number of flowers with Petal.Length
#higher than 5.1.

iris
iris$Petal.Length
iris$Petal.Length > 5.1 
iris$Petal.Length[iris$Petal.Length > 5.1]
length(iris$Petal.Length[iris$Petal.Length > 5.1])

#En total hay 34 flores con mayor petal.length 5.1.

#------------------------------------------------------------

#EJERCICIO 2: Check which species have flowers with sepal
#width higher than 3.5 and lower than 4. Hint. & will be 
#needed when more than one condition is needed. Besides, 
#for simplifying the result you may need unique(). Use ? 
#for details.

iris$Species[iris$Sepal.Width > 3.5 & iris$Sepal.Width < 4.1]

#------------------------------------------------------------

#EJERCICIO 3: How many flowers of each species are there? 
#Hint. Function table() may be useful.

summary(iris$Species)
table(iris$Species)

#------------------------------------------------------------

#EJERCICIO 4: Calculate the sepal width average of the flowers
#whose sepal width is below average

media <- mean(iris$Sepal.Width)
media_flores_menor_que_media <- mean(iris$Sepal.Width[iris$Sepal.Width < media])

#------------------------------------------------------------

#EJERCICIO 5: Calculate the median of the petal width for each 
#species separately (hacerlo bien)

#paso1: construir un vector que indique las filas de iris en
#las que Specis es igual a "setosa"


setosa_TRUE <- iris$Species == "setosa"

iris$Sepal.Width#con option y flechas voy moviendo la línea para arriba y para abajo
iris$Sepal.Width[setosa_TRUE]
#calculo la mediana de estos valores
mediana_setosa <- median(iris$Sepal.Width[setosa_TRUE])

virginica_TRUE <- iris$Species == "virginica"
iris$Sepal.Width[virginica_TRUE]
mediana_virginica <- median(iris$Sepal.Width[virginica_TRUE])


versicolor_TRUE <- iris$Species == "versicolor"
iris$Sepal.Width[versicolor_TRUE]
mediana_versicolor <- median(iris$Sepal.Width[versicolor_TRUE])

### Para construir un vector a partir de una columna: iris$Species, 
#iris[["Sepal.Width"]], iris[[1]] (este último se refiere a la columna 1,2,3...)
## unique(vector) me indica que elementos únicos tiene el vector

#------------------------------------------------------------

#EJERCICIO 6: Calculate the minimum and maximum petal length for every versicolor
#flower. Then count how many setosa and virginica flowers there are with the petal
#length between those values.

iris %>% 
  filter(Species == "versicolor") %>% 
  summarise(maximum = max (Petal.Length), minimum = min(Petal.Length))

a <- iris %>% 
  filter(Species == c("setosa","virginica")) %>% 
  filter(Sepal.Length > 3 & Sepal.Length < 5.1)

nrow(a)

#------------------------------------------------------------

#EJERCICIO 7: What happens if you use plot() with the data frame iris?

plot(iris)

#------------------------------------------------------------

#EJERCICIO 8: If you type Titanic on the console you will set a data set with a 
#not too comfortable format for analysis. Use as.data.frame() to convert it to a 
#data frame and assign it to a new variable (object) in R (pick a name of your choice).
#Now that data frame is on memory.

class(Titanic)
titanic_df <- as.data.frame(Titanic)

# - Verify that data frame is in fact a data frame.

class(titanic_df)

# - Check the classes of the data frame’s columns

class(titanic_df$Class)
class(titanic_df$Sex)
class(titanic_df$Age)
class(titanic_df$Survived)
class(titanic_df$Freq)

# - Count (or sum) the number of people who survived and the number of people who didn’t. 
#If you have questions about the data, type ? Titanic to get into the help (yes! You also 
#have help for datasets.).

titanic_df2 <- titanic_df %>% 
  mutate(survived_aux = if_else(Survived == "No",0,1)) #%>% 
  #select(Survived,survived_aux)

sum(titanic_df2$survived_aux)

# - Count the number of children who were on the ship.

titanic_df3 <- titanic_df %>% 
  mutate(age_aux = if_else(Age == "Child",TRUE,FALSE))

contador <- 0
for(i in 1:length(titanic_df[[1]])) {
  if (titanic_df3$age_aux[i]==TRUE) 
    contador <- contador + titanic_df3$Freq[i]
}
contador

# - Count the number of men from first class

titanic_df4 <- titanic_df %>% 
  mutate(class_aux = if_else(Class == "1st",TRUE,FALSE))

titanic_df4

contador_men_1st_class <- 0
for(i in 1:length(titanic_df[[1]])) {
  if (titanic_df4$class_aux[i] == TRUE & titanic_df4$Sex[i] == "Male") 
    contador_men_1st_class <- contador_men_1st_class + titanic_df4$Freq[i]
}
contador_men_1st_class

# - Were there any children among the crew? And women?

titanic_df %>% 
  filter(Class == "Crew" & Age == "Child")

#esto se puede mejorar, cambiando el for por un while (creo) y añadiendo un break.

titanic_df

si_o_no_niños <- FALSE
si_o_no_mujeres <- FALSE
for(i in 1:length(titanic_df[[1]])) {
  if (titanic_df$Class[i] == "Crew" & titanic_df$Age[i] == "Child" & titanic_df$Freq[i] != 0) 
    si_o_no_niños <- TRUE
}

for(i in 1:length(titanic_df[[1]])) {
  if (titanic_df$Class[i] == "Crew" & titanic_df$Sex[i] == "Female" & titanic_df$Freq[i] != 0) 
    si_o_no_mujeres <- TRUE
}

si_o_no_niños
si_o_no_mujeres


#---------------------------%%%%%---------------------------------
#---------------------------%%%%%---------------------------------
#-------------------------SECCIÓN 2-------------------------------
#---------------------------%%%%%---------------------------------
#---------------------------%%%%%---------------------------------

#EJERCICIO 1: 

# - Read all the sheets of the Excel file01_ ACCIDENTES POR TIPO EN  DISTRITOS.xls. You should find 
#some trouble with one of the years if you just copy and paste what I typed. Fix it.


#------------------------------------------------------------

#EJERCICIO 2: (janitor)

# - Install the janitor package and load it.Hint.library().

library("janitor")

# - Use clean_names() on the data frame iris to fix its names. Hint. Bear in mind that if you just 
#type clean_names(mi_data_frame_guay_recien_creado), R will show you on the console the result, but the 
#names won’t be overwritten. You need to assign that result to the data frame with <-.

iris_nombre <- clean_names(iris) #lo que nos hace es poner en minúsculas y con _ los nombres de las columnas
#del data frame.
head(iris_nombre)

#------------------------------------------------------------

#EJERCICIO 3:

# - Read the iris2.csv file with the read_csv() function (readr package).

library(readr)

iris2 <- read_csv2("~/Desktop/Máster Ciencia de Datos/Herramientas de programación/data/iris2.csv")
iris2
glimpse(iris2)

# - How many columns are there? Which are their names? Does it make any sense?

summary(iris2)

#---------------------------%%%%%---------------------------------
#---------------------------%%%%%---------------------------------
#-------------------------SECCIÓN 3-------------------------------
#---------------------------%%%%%---------------------------------
#---------------------------%%%%%---------------------------------

#EJERCICIO 1: What are the differences between glimpse(df_mtcars)and df_mtcars %>% glimpse()?

df_mtcars <- read_csv("~/Desktop/Máster Ciencia de Datos/Herramientas de programación/data/mtcars.csv")
df_mtcars

df_mtcars %>% glimpse()
glimpse(df_mtcars)

#es lo mismo.

#------------------------------------------------------------

#EJERCICIO 2: In the mtcars data frame decide which columns can be stored as integer without losing 
#information and change them. For changing the type of an object or vector you can use as.integer(). 
#For instance, class(as.integer(4, 6, 1)).

#???????????????????????????????????
df_mtcars
as.integer(df_mtcars$cyl)
as.integer(df_mtcars$hp)
as.integer(df_mtcars$vs)
as.integer(df_mtcars$am)
as.integer(df_mtcars$gear)
as.integer(df_mtcars$carb)
df_mtcars
class(df_mtcars)

#------------------------------------------------------------

#EJERCICIO 3(SECCIÓN 3): (3)

df_inventado <- tibble(
  ind = indices, 
  long = length_sim, 
  ancho = width_sim, 
  clientes = customers_daily, 
  euros = income_daily, 
  col = colors
)
df_inventado
glimpse(df_inventado)

df_inventado %>%
  mutate(media=euros/clientes) %>%
  select(clientes,euros,media)

my_matrix <- matrix(c(10, 12, 9, 1, 5, 7, -1, -6, 8, 100, 200, 300), nrow = 3)
my_matrix
my_matrix[[1,1]]

#------------------------------------------------------------

#EJERCICIO 4: Based on the starwars data frame, answer these questions.

starwars

# - What are the names of the columns?

names(starwars)

# - What are the classes of each column?

class(starwars$name)
class(starwars$height)
class(starwars$mass)
class(starwars$hair_color)
class(starwars$skin_color)
class(starwars$eye_color)
class(starwars$birth_year)
class(starwars$sex)
class(starwars$gender)
class(starwars$homeworld)
class(starwars$species)
class(starwars$films)
class(starwars$vehicles)
class(starwars$starships)

summary(starwars)

# - What are the dimensions of the data frame (number of rows and columns)?

nrow(starwars)
ncol(starwars)

#------------------------------------------------------------

#EJERCICIO 5: Get the distinct combinations between eye_color and gender from starwars
#and create a data frame with them. Export this data frame or tibble to a csv file using 
#a function from the readr library. Hint. After running library(readr), write on the 
#console or the script write_ and let the autocompletion propose you some alternatives. 
#Decide which function you should use.Another hint.There are several solutions for exporting
#the file. Anyway, remember to use ?for reading the help of a function. ????

starwars_df <- starwars %>% 
  select(eye_color, gender)

starwars_df
as.data.frame(starwars_df)

write.csv(starwars_df, file = "starwars_eye_and_gender.csv")

#------------------------------------------------------------

#EJERCICIO 6: Read the help of na.omit() function for removing all the rows with at least one 
#NA value from the starwars data frame. Create a new data frame with the data. Export the new 
#data frame to a csv file (separated with comma).

library(readr)
library(dplyr)

starwars

starwars_sin_NA <- as.data.frame(na.omit(starwars))

write_csv(starwars_sin_NA,file = "starwars_sin_NA.csv")

#------------------------------------------------------------

# EJERCICIO 7:

# - Read the file volpre2019.csv and create a data frame with its data. Name it however you like. 
#It stores data about the volume and the price of lots of products at MercaMadrid.

mercamadrid <- read_csv2("~/Desktop/Máster Ciencia de Datos/Herramientas de programación/data/volpre2019.csv")

mercamadrid

# - Call the library janitor (install it if needed) and use the clean_names() function on the data 
#frame(overwrite it).

library(janitor)

mercamadrid_cleaned <- clean_names(mercamadrid)

# - Explore the data frame with the functions you know. nrow, ncol (you can use dim()instead), glimpse().
# Remember to use summary() too.

nrow(mercamadrid_cleaned)
ncol(mercamadrid_cleaned)
names(mercamadrid_cleaned)
dim(mercamadrid_cleaned)

mercamadrid_cleaned %>% glimpse()

mercamadrid_cleaned %>% 
  summary()


# - Count how many NA values there are in the fecha_desde column.Hint.For now it is OK if you 
#just use is.na() for building a logical vector and then sum() for adding the number of cases with NA.

vector_true <- as.data.frame(mercamadrid_cleaned) %>% 
  summarise(is.na(fecha_desde))

sum(vector_true)


# - Exclude the cases with fecha_desde as NA and overwrite the data frame. ??????????

mercamadrid_cleaned %>% 
  select(na.omit(fecha_desde))


# - 

#------------------------------------------------------------

# EJERCICIO 8: Based on the storms data frame, built on the dplyr-aggregate section.

# - What can you learn applying summary() to the tibble?

storms
summary(storms)

# - Which are the different values at the name column? These are the storms and 
#hurricanes we will be working with. Create a tibble with one column containing this unique names.

storms %>% 
  distinct(name)

# - Which are the different available status? Don’t create the tibble: just print it on the console.

as.data.frame(storms) %>% 
  distinct(status)

# - Which are the different combinations between status and pressure?

storms %>% 
  distinct(status, pressure)

#------------------------------------------------------------

# EJERCICIO 9: For the storms, depressions and hurricanes that took place between 1975 and 1980, 
#create a new column with the mean and standard deviation of the wind. Create a new column substacting 
#the mean from wind and then divide by the standard deviation. Calculate with summarise() the mean and 
#the standard deviation of this new column. What happened?


storms %>% 
  filter(year >= 1975 & year <= 1980) %>% 
  group_by(status) %>% 
  summarise(viento_medio = mean(wind,na.rm = TRUE), desviación_viento = sd(wind))

storms %>% 
  filter(year >= 1975 & year <= 1980) %>% 
  mutate(wind = wind) %>% 
  summarise(viento_medio = mean(wind,na.rm = TRUE), desviación_viento = sd(wind))

#.........

#------------------------------------------------------------

# EJERCICIO 10: 

# - For the registers where hu_diameter is not NA, calculate the minimun pressure, the median, the 
#average and the maximum

mean(storms$hu_diameter,na.rm = TRUE)
max(storms$hu_diameter,na.rm = TRUE)
min(storms$hu_diameter,na.rm = TRUE)
median(storms$hu_diameter,na.rm = TRUE)

# - Are there more registers below the average or above?



#------------------------------------------------------------

# EJERCICIO 11: For the hurricane, calculate the average ts_diameter.Hint. It is not NA.

storms %>% 
  filter(status == "hurricane") %>% 
  summarise(diameter_medio = mean(ts_diameter, na.rm = TRUE))
  
  
#---------------------------%%%%%---------------------------------
#---------------------------%%%%%---------------------------------
#-------------------------SECCIÓN 4-------------------------------
#---------------------------%%%%%---------------------------------
#---------------------------%%%%%---------------------------------
  
  