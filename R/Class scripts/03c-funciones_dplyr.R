library(dplyr)

starwars_redux <- starwars %>% 
  select(name, homeworld, height)



# Cuántos homeworld distinots hay?

starwars_redux %>% 
  distinct(homeworld)

distinct(starwars_redux, homeworld)


# Altura media de todo el conjunto de datos

mean(starwars_redux$height, na.rm = TRUE)

#con dplyr:

starwars_redux %>% 
  summarise(altura_media = mean(height,na.rm = TRUE))

# quiero calcular la altura media de cada uno de los sitios de homeworld. Esto se hace combinando group_by y summarise

starwars_redux %>% 
  group_by(homeworld) %>% 
  summarise(altura_media = mean(height,na.rm = TRUE))

# Cuántos personajes de cada sitio ?

starwars_redux %>% 
  group_by(homeworld) %>% 
  summarise(altura_media = mean(height,na.rm = TRUE), cuantos_personajes = n())


starwars_redux %>% 
  group_by(homeworld) %>% 
  summarise(altura_media = mean(height,na.rm = TRUE), cuantos_personajes = n(),
            altura_mediana = median(height))


