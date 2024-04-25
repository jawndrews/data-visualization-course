## final project - deep sea coral and sponge data ##
## author - Jonathan Andrews ##

# install and load packages
install.packages("tidyverse")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("maps")
library(tidyverse)
library(dplyr)
library(ggplot2)
library(maps)

# read and view data
data <- read.csv("data/deep_sea_corals.csv")
View(data)


## geospatial analysis ##
# select relevant variables and remove null values
spatial_data <- data %>%
  select(latitude, longitude, DepthInMeters, Phylum) %>%
  filter(longitude > -97, longitude < -44, latitude > 17, latitude < 44) %>%
  drop_na()
View(spatial_data)

# map visualization using maps and ggplot2
world_map <- map_data("world")

# plot base map
world_base <- ggplot(world_map, aes(x = long, y = lat, group = group)) + 
  geom_polygon(fill = "grey") +
  coord_fixed(1.3, xlim = c(-98, -45), ylim = c(16, 45)) #crop to north atlantic region

# plot spatial data on map base
world_map <- world_base + 
  geom_point(data = spatial_data, aes(x = longitude, y = latitude, color = DepthInMeters, shape = Phylum), size = 1, alpha = 0.7, inherit.aes = FALSE) +
  scale_color_gradient(low = "turquoise3", high = "#002634") +
  guides(color = guide_colorbar(title = "Depth (Meters)", reverse = TRUE)) +
  scale_shape_manual(values = c("Cnidaria" = 16, "Porifera" = 17), labels = c("Coral", "Sponge")) +
  labs(title = "Deep-Sea Coral and Sponge Observations in the North Atlantic", x = "Longitude", y = "Latitude", shape = "Entity")
world_map


## temp vs depth scatter ##
ggplot(data, aes(x = DepthInMeters, y = Temperature)) +
  geom_point(color = "dodgerblue4", alpha = 0.3) +
  labs(title = "Temperature vs Depth in Deep-Sea Corals and Sponges in the North Atlantic", x = "Depth (meters)", y = "Temperature (celsius)")
