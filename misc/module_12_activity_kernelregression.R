# read data
data <- read.csv("data/monthly_unemployment.csv", header=TRUE, sep=",")

# plot data
plot(data$Year, data$Value, ylim=c(0,11))

# kernel regression
NW = ksmooth(data$Year, data$Value,kernel = "normal", bandwidth=6)

# plotting kernel regression line
plot(data$Year, data$Value, ylim=c(0,11))
lines(NW, col="blue")