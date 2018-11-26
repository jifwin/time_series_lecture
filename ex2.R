library(forecast)
time_series_raw = ts(readRDS("/home/grzegorz/time_series_lecture/seasonal_time_series.rds"))
plot(time_series_raw)

#find periods of time_series and put it here (you can use acf and diff)
periods = c(...)

#convert time_series to Multi-Seasonal Time Series (msts), include periods
time_series = msts(..., seasonal.periods=...)

#choose number of hamornics for each period, experiment with different values
K = c(...)

#fit a model, use auto.arima (it may take a while) or choose orders by hand
#we don't want SARIMA model, thus seasonal=TRUE, season is handled by fourier
model = auto.arima(..., xreg=fourier(..., K=...), seasonal=FALSE)
model = Arima(..., order=c(...), xreg=fourier(..., K=...))

#forecast
forecast_length = ...
forecasted_series = forecast(model, h=forecast_length, xreg=fourier(..., K=..., h=forecast_length))
plotted_previous_length = 200
plot(forecasted_series)


