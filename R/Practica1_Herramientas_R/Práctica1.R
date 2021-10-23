# --------- LIBRERIÍAS --------- 

library(readr)
library(janitor)
library(dplyr)
library(tidyr)
library(ggplot2)
library(purrr)


# Ejercicio 1 -------------------------------------------------------------

df_mmm <- read_csv("mktmix.csv")
df_mmm # in order to see the tibble.
as.data.frame(df_mmm) # in order to see it in data frame mode, but we can ommit this.

df_mmm <- clean_names(df_mmm) # We write the names of the columns in a clearer and cleaner way


# Ejercicio 2 -------------------------------------------------------------

# Let's attend to the dimensions of the data frame.
# It can be easily obtained with the command dim.
dim(df_mmm)

# Otherwise, we can use both nrow and ncol commands which show us the number
# of columns and the number of rows that the data frame has, respectively.
nrow(df_mmm)
ncol(df_mmm)

# We have 104 rows and 9 columns

# Let's attend now to the class of two of the columns of the data frame making use
# of the 'class' command. 
class(df_mmm$base_price)
class(df_mmm$discount)

# Both classes are numeric. We know that inside the 'numeric' class, we have both
# integers and double (double precision) numbers. Since we are talking about 
# prices and discounts, we can imagine that it refers to the double class.


# Ejercicio 3 -------------------------------------------------------------

# Veamos primero que la class de newspaper_inserts es "character" 
class(df_mmm$newspaper_inserts)

# SI, luego hagamos lo que el ejercicio nos pide

# We use the mutate function and if_else in order to change values in the column newspaper_inserts.
# We make this happen making use of the is.na(x) function. If is.na(x) is TRUE, then we put the value "0"
# otherwise, we write the value "1"

df_mmm <- df_mmm %>% 
  mutate (newspaper_inserts = 
            if_else(is.na(newspaper_inserts),
                    0, 1))

# Let's check if the class has changed
class(df_mmm$newspaper_inserts) # YES, it has changed into numeric.


# Ejercicio 4 -------------------------------------------------------------

# Eliminamos los valores NA y vemos qué valores únicos tenemos en la columna 
# website_campaign
unique(na.omit(df_mmm$website_campaign))

# Now, we have to create new columns. 
# This columns will be called facebook, twitter and website_campaign.
# If we have a row with the value of facebook in the column website_campaign,
# then, in the column facebook we will have the value 1, otherwise, the value 0.
# So on with columns website_campaign and twitter.

# The idea is quite simple, making use of mutate and if_else, we ask first if there is 
# any NA values on the column. If there is a NA, then the column will take the value 0.
# If there is no NA, then we have to check if it has the value 'facebook' for example. 
# If it does, then the column facebook must have the value 1 and, otherwise, the value 0.
# The same happens to columns twitter and website_campaign.
df_mmm <- df_mmm %>% 
  mutate(
    facebook = if_else(is.na(df_mmm$website_campaign), 0, 
                       if_else(df_mmm$website_campaign == "Facebook", 1, 0)), 
    twitter = if_else(is.na(df_mmm$website_campaign), 0, 
                      if_else(df_mmm$website_campaign == "Twitter", 1, 0)), 
    website_campaign = if_else(is.na(df_mmm$website_campaign), 0, 
                               if_else(df_mmm$website_campaign == "Website Campaign", 1, 0))
)

# Veamos si únicamente tenemos 0s y 1s:
unique(df_mmm$facebook)
unique(df_mmm$twitter)
unique(df_mmm$website_campaign)

# YES!

# Ejercicio 5 -------------------------------------------------------------

# Making use of the ggplot2 library, we can make a line plot with the command
# geom_line.

ggplot(df_mmm) + 
  geom_line(aes(y = new_vol_sales, x = 1:nrow(df_mmm)))


# Ejercicio 6 -------------------------------------------------------------

# We plot both the histogram and the boxplot making use of the library ggplot2.

#Histogram
ggplot(df_mmm) + 
  geom_histogram(aes(new_vol_sales), col = "black", fill = "darkorchid4")

#Boxplot
ggplot(df_mmm) + 
  geom_boxplot(aes(y = new_vol_sales), col = "black", fill = "darkorchid4")

# We can imagine that the median will be around 19.900 more or less. Let's check it

median(df_mmm$new_vol_sales)

# The exact value is 19943.5 which is almost what we have just mentioned.


# Ejercicio 7 -------------------------------------------------------------

# First, we select tv, radio and stout columns and we store them in a data frame called 
# df_media
df_media <- df_mmm %>% 
  select(tv, radio, stout)

# We use the code provided by the exercise
df_media <- df_media %>%
  pivot_longer(everything())

# Let's have a look at the data frame:
df_media

# Now, we have to plot the evolution of these columns in an only one plot.
# In order to achieve it we are going to use 'facet_grid'. This command forms a
# matrix of panels depending on the name(in this case). Name corresponds to tv, radio
#or stout. This way we will obtain what we want. Three plots in 1.

ggplot(df_media, aes(x = 1:nrow(df_media), y = value, col = name)) +
  geom_line() +
  facet_grid(name ~ ., scales = "free")


# Ejercicio 8 -------------------------------------------------------------

# First, we see what type of values takes in_store column.
df_mmm

# Now we have to do a scatter plot comparing new_vol_sales column against in_store column.
# When we say new_vol_sales against in_store is the same as saying new_vol_sales vs in_store.
# This means that we want the column ........

ggplot(df_mmm) + 
  geom_point(aes(x = in_store, y = new_vol_sales))


# Ejercicio 9 -------------------------------------------------------------

# Version 1: colour each dot based on newspaper_inserts column

ggplot(df_mmm) + 
  geom_point(aes(x = in_store, y = new_vol_sales, col = as.factor(newspaper_inserts)))

# Version 2: colour each dot based on tv column

ggplot(df_mmm) + 
  geom_point(aes(x = in_store, y = new_vol_sales, col = tv))


# Ejercicio 10 ------------------------------------------------------------

# We will consider 1 when we have discount and 0 when we do not have it ??????

df_mmm <- df_mmm %>% 
  mutate(discount_yesno = if_else(discount != 0, 1, 0))

df_mmm <- df_mmm %>% 
  mutate(discount_yesno = as.factor(discount_yesno))

df_mmm %>% 
  group_by(discount_yesno) %>% 
  summarise(base_price_avg = mean(base_price,na.rm = TRUE)) %>% 
  ggplot() +
  geom_col(aes(x = discount_yesno, y = base_price_avg))
  


# Ejercicio 11 ------------------------------------------------------------



model_fit<- function (character, df) {
  df_aux <- df %>% 
    select(character, new_vol_sales)
  
  my_model <- lm(new_vol_sales ~ ., data = df_aux)
  return(summary(my_model)$adj.r.squared)
}

model_fit(c("tv", "radio", "stout"), df_mmm)


# Ejercicio 12 ------------------------------------------------------------

# First, we create a list with the three sets of variables:

set1 <- c("base_price", "radio", "tv", "stout")
set2 <- c("base_price", "in_store", "discount", "radio", "tv", "stout")
set3 <- c("in_store", "discount")

lista <- list(set1, set2, set3)

# We are going to use both functions. First sapply and then map

sapply(lista, model_fit,  df = df_mmm)


map_dbl(lista, model_fit, df = df_mmm)

# We conclude that the best one is the set2 due to its high model_fit value.
       