# install library
install.packages("forecast")
library(forecast)

# read data
data <- read.csv(file="data/amtrak.csv", head=TRUE, sep=",")
data <- ts(data$Ridership, start=c(1991, 1), freq=12) # create time series object
class(data)

# values
start(data)
end(data)
frequency(data)

# summary
summary(data)

# plot data
plot(data)
abline(reg=lm(data ~ time(data)))

cycle(data)
boxplot(data ~ cycle(data))

# decompose data
ts.data <- ts(data, frequency=12)
decompose.data <- decompose(ts.data, "multiplicative")
plot(decompose.data)
plot(decompose.data$trend)
plot(decompose.data$seasonal)
plot(decompose.data$random)

# Other exploraty graphs
monthplot(data)
seasonplot(data)

# fit the model - auto.arima finds the best ARIMA model
arima.model <- auto.arima(data) 
arima.model

# Trace how the auto.arima find the best model
auto.arima(data, ic="aic", trace=TRUE)

# Forecasting
forecast <- forecast(arima.model, h=10*12)
plot(forecast)
