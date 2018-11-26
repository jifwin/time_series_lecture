#regular time series exercise: fit all possible models and compare them
library(forecast)
time_series = ts(readRDS("/home/grzegorz/time_series_lecture/regular.rds"))
plot(time_series)

p_max = 5
q_max = 5
results <- data.frame(matrix(ncol = 4, nrow = 0))

colnames(results) <- c("aic", "aicc", "bic", "pvalue")

#functions:
#Arima (forecast)
#Box.test (stats)