# assignment 2
# read data (iris data comes pre-loaded in R, under the iris object)
data <- iris

# select variables for clustering (exclude species)
data <- data[, 1:4]

# calculate euclidean distance
distance <- dist(data)

# k-means clustering (k=3 - we expect 3 species)
result <- kmeans(distance, 3)
result

# plotting results
library(ggplot2)
data$cluster <- as.character(result$cluster)
ggplot(data, aes(x=Sepal.Length, y=Petal.Length, color=cluster)) +
  geom_point(size=2) +
  geom_text(aes(label=cluster)) +
  labs(title = "k-Means Clustering Analysis", x="Sepal Length", y="Petal Length")