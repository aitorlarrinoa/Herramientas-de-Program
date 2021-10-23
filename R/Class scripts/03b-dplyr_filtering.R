###########################
## data.frames and dplyr ##
## Leonardo Hansa        ## 
## September 2021        ##
###########################

library(dplyr)

# Filtering rows ----------------------------------------------------------

glimpse(starwars)

# Filter in the base-R way
starwars$height > 175
starwars$name[starwars$height > 175]

# Filter in the dplyr way
starwars %>% 
  filter(height > 175) 

# ahora solo me quiero quedar con los nombres, lo engancho con otro %>% 
starwars %>% 
  filter(height > 175) %>% 
  select(name) #este no tiene en cuenta los NA, en R base starwars[starwars$height > 175, c("name","height")] si tiene
#en cuenta los NA.

# library(data.table) es complicado pero lo más rápido que hay en R.

starwars %>% 
  filter(height != 202) %>% 
  nrow()

# characters
starwars %>% 
  filter(hair_color == "brown")

# AND operator
starwars %>% 
  filter(skin_color == "light", height >= 165)

# OR operator
starwars_filtrado_2 <- starwars %>% 
  filter(skin_color == "light" | height < 100)



#Distinct

# Distinct  ---------------------------------------------------------------
unique(starwars$hair_color)

starwars %>% 
  distinct(hair_color)


starwars %>% 
  distinct(hair_color, skin_color)


# NA ----------------------------------------------------------------------
unique_hair_color <- unique(starwars$hair_color)
unique_hair_color

# This NA is the only value not written within ". But the vector is a character vector.

class(unique_hair_color)

class(unique_hair_color[1])

# A NA value
class(unique_hair_color[2])

# Exercise. Repeat the same procedure with height column and see what class NA belong to this time.
# Exercise. Apply the class() function to NA and see the result.

mean(starwars$height)

1 + NA

mean(starwars$height, na.rm = TRUE)


# is.na() is a R base function that allows us detecting NA values. Simple example:

vector_with_NA <- c(1, NA, 3)
is.na(vector_with_NA)

!is.na(vector_with_NA)


starwars %>% 
  filter(is.na(height))

starwars %>% 
  filter(!is.na(height))

starwars %>% 
  filter(is.na(height) | is.na(hair_color))


# Exercise. Keep only the rows with both height and mass available and create a 
# new column with the BMI (m/h2). Finally select the name of the character and 
# the new column.


# Row numbers --------------------------------------------------------------


starwars %>% 
  slice(1:3, 100:103)













