# read data and initialize libraries
cars <- read.csv("data/mtcars.csv", header=TRUE, sep=",")
library(ggplot2)

# assign variables
mpg = mtcars$mpg
hp = mtcars$hp
wt = mtcars$wt

# summary statistics
summary(mtcars$mpg)
summary(mtcars$hp)
summary(mtcars$wt)

# correlation analysis
cor(mpg, hp)
cor(mpg, wt)
cor(hp, wt)

# visualization
# scatterplot of mpg vs hp
ggplot(cars, aes(x = hp, y = mpg)) +
  geom_point(color = "steelblue", size=3) +
  labs(title = "MPG vs Horsepower",
       x = "Horsepower (hp)",
       y = "Miles per Gallon (mpg)")

# scatterplot of mpg vs wt
ggplot(cars, aes(x = wt, y = mpg)) +
  geom_point(color = "coral", size=3) +
  labs(title = "MPG vs Weight",
       x = "Weight (per 1000lbs)",
       y = "Miles per Gallon (mpg)")

# scatterplot of hp vs wt
ggplot(cars, aes(x = wt, y = hp)) +
  geom_point(color = "orchid", size=3) +
  labs(title = "MPG vs Horsepower",
       x = "Weight (per 1000lbs)",
       y = "Horsepower (hp)")
