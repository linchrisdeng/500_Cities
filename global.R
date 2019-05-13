library(tidyverse)

df = read.csv("500cities.csv")
df$Geolocation = gsub("[()]", "", df$Geolocation)
df = df %>% separate(Geolocation, c("latitude", "longitude"), sep = ",")
df$latitude = as.numeric(df$latitude)
df$longitude = as.numeric(df$longitude)
