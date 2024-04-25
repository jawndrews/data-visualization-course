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
data <- read.csv("data/deep_sea_corals_full_dataset.csv")
View(data)



## geospatial analysis ##
# select relevant variables and remove null values
spatial_data <- data %>%
  select(latitude, longitude, DepthInMeters, Phylum) %>%
  drop_na()

# map visualization using maps and ggplot2
# map data including usa, mexico, and cuba
world_map <- map_data("world")
gulf_countries <- c("USA", "Mexico", "Cuba")
gulf_map <- world_map[world_map$region %in% gulf_countries,]

# plot base map of the gulf region
gulf_base <- ggplot(gulf_map, aes(x = long, y = lat, group = group)) + 
  geom_polygon(fill = "grey") +
  coord_fixed(1.3, xlim = c(-98, -79), ylim = c(18, 31)) #crop to gulf region

# plot spatial data on map base
gulf_map <- gulf_base + 
  geom_point(data = spatial_data, aes(x = longitude, y = latitude, color = DepthInMeters, shape = Phylum), size = 2, alpha = 0.7, inherit.aes = FALSE) +
  scale_color_gradient(low = "turquoise3", high = "#002634") +
  guides(color = guide_colorbar(title = "Depth (Meters)", reverse = TRUE)) +
  scale_shape_manual(values = c("Cnidaria" = 16, "Porifera" = 17), labels = c("Coral", "Sponge")) +
  labs(title = "Deep-Sea Coral and Sponge Observations in the Gulf of Mexico", x = "Longitude", y = "Latitude", shape = "Entity")
gulf_map



## temperature depth regression model ##
temperature_data <- data %>%
  select(DepthInMeters, Temperature) %>%
  filter(DepthInMeters < 2000) %>% 
  drop_na()

# fit models
model <- lm(Temperature ~ DepthInMeters, data = temperature_data)
summary(model)

# plot with regression line
ggplot(temperature_data, aes(x = DepthInMeters, y = Temperature)) +
  geom_point(color = "turquoise3", alpha = 0.4) +
  geom_smooth(method = "lm", se = FALSE, color = "darkorange") +
  labs(title = "Linear Regression of Temperature by Depth", x = "Depth (meters)", y = "Temperature (celsius)")



## species depth k-means clustering ##
# select relevant variables and remove null values
depth_data <- data %>%
  select(DepthInMeters, ScientificName) %>%
  drop_na() %>%
  group_by(ScientificName) %>%
  summarize(AvgDepth = mean(DepthInMeters, na.rm = TRUE),
            DepthSD = sd(DepthInMeters, na.rm = TRUE)) %>%
  ungroup() %>%
  drop_na() #only include species with 2 or more observations
View(depth_data)

# k-means clustering
set.seed(12345)
k <- 3 #epipelagic, mesopelagic, bathypelagic zones
result <- kmeans(depth_data[, c("AvgDepth", "DepthSD")], centers=k)
depth_data$cluster <- factor(result$cluster)

# plot k-means results
ggplot(depth_data, aes(x = AvgDepth, y = DepthSD, color = cluster)) +
  geom_point(size=2) +
  geom_text(aes(label=cluster), vjust=1.5, hjust=1.5) +
  scale_color_manual(values = c("orange", "seagreen", "steelblue")) +
  labs(title = "K-Means Clustering Analysis of Species by Depth", 
       x = "Average Depth (meters)", 
       y = "Standard Deviation of Depth", 
       color = "Cluster")



