#regular time series exercise: fit all possible models and compare them
library(forecast)
time_series = ts(readRDS("/home/grzegorz/time_series_lecture/regular.rds"))
plot(time_series)

p_max = 5
q_max = 5

results <- data.frame(matrix(ncol = 4, nrow = 0))
colnames(results) <- c("aic", "aicc", "bic", "pvalue")

#todo: jak dziala p-value - zrozumiec
#wartosc > 0.05 nie pozwala na odrzucenie hipotezy zerowej o braku korelacji
#wartosc < 0.05 pozwala na odrzucenie hipotezy zerowej o braku korelacji
#todo: zobaczyc na pozostale wartosci z z Box.test i jak tego uzywac
for (p in 0:p_max) {
  for (q in 0:q_max) {
    for (d in 0:1) {
      model_name = paste(p, d,q)
      model = Arima(time_series, order=c(p,d,q))
      boxtest = Box.test(model$residuals, type="Ljung-Box")
      results[model_name,] = c(model$aic, model$aicc, model$bic, boxtest$p.value)
    }
  }
}

auto_model = auto.arima(time_series)


#ex2 source
period1 = 12 #todo: 24
period2 = 30 #todo: 60

sampling = 0.5
sd = 0.5
x = seq(from=1, by=sampling, to=period2*10)
phis = c(0.9, -0.2)
thetas = c(0.2)
arima_series = 0.2*rowSums(generate_series(phis, thetas, sd, length(x)))
seasonal_series_1 = 0.2*sin(2*pi/(period1)*x)+0.2*sin(2*2*pi/(period1)*x)
seasonal_series_2 = 0.8*sin(2*pi/(period2)*x)
y = arima_series + seasonal_series_1 + seasonal_series_2
saveRDS(y, "/home/grzegorz/time_series_lecture/seasonal_time_series.rds")


periods = c(60, 24)
#convert time_series to msts, include periods
time_series = msts(y, seasonal.periods=periods)

#choose number of hamornics for each periods, experiment with different values
K = c(1,2)

#fit a model, use auto.arima (it may take a while) or choose orders by hand
model = auto.arima(time_series, xreg=fourier(time_series, K=K), seasonal=FALSE)
forecasted = forecast(model, h=200, xreg=fourier(time_series, K=K, h=200))
plot(forecasted, 200)

#todo: move these things to zadanie1.R, copy 
