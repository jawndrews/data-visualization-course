# read data
cars <- read.csv("data/data_mtcars.csv", header=TRUE, sep=",")

# calculate euclidean distance
distance <- dist(cars)

# k-means
results <- kmeans(distance, 3)
cars$cluster <- as.character(results$cluster)

# plotting results
library(ggplot2)

ggplot(cars, aes(x=mpg, y=hp, color=cluster)) +
  geom_point() +
  geom_text(aes(label=model))