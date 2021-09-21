setwd("/Users/abhishekpadalkar/Documents/IRELAND Admissions/NCI/Course Modules/Modules/Sem 1/Statistics/Project TABA/Time Series/")

library(readxl)
library(data.table)
library(fpp2)
library(tseries)
library(mFilter)
library(hrbrthemes)
library(grid)
library(ggplot2)

read_excel_allsheets <- function(filename, tibble = FALSE) {
  # I prefer straight data.frames
  # but if you like tidyverse tibbles (the default with read_excel)
  # then just pass tibble = TRUE
  sheets <- readxl::excel_sheets(filename)
  x <- lapply(sheets, function(X) readxl::read_excel(filename, sheet = X))
  if(!tibble) x <- lapply(x, as.data.frame)
  names(x) <- sheets
  x
}

irl_trade <- read_excel_allsheets('Ireland International Trade in goods.xlsx')


imp_irl_year_wise <- irl_trade$`Ireland Import Trade`[grep("Jan.-Dec. ", irl_trade$`Ireland Import Trade`$PERIOD), ]

imp_irl_year_wise <- imp_irl_year_wise[-nrow(imp_irl_year_wise), ]

# str(irl_trade$`Ireland Import Trade`)

imp_irl_year_wise$PERIOD <- sub(".* ", "", imp_irl_year_wise$PERIOD) # => Removing "Jan.-Dec." from PERIOD to have only year.

irl_import_yearly <- ts(as.numeric(imp_irl_year_wise$Value)/1000000, start = 1988, frequency = 1)
plot(irl_import_yearly)
autoplot(irl_import_yearly, ylab = "Import in EUR(millions)")
# This time series is already a smooth line, no need for using smoothing models. 
# But let's try moving averages.
autoplot(irl_import_yearly, ylab = "Import in EUR(millions)") + autolayer(ma(irl_import_yearly, 3)) + autolayer(ma(irl_import_yearly, 5))

# Another important function, ggtsdisplay. It gives us autocorrelation function and a partial autocorrelation function.
ggtsdisplay(irl_import_yearly) # It's a useful plotting function in assesing the TS model

# Decomposing the seasonality in our ts. 
seasonplot(irl_import_yearly) # => Error: Data are not seasonal

# Checking for trend : By plot we can see that there is an upward trend, but we still check with a test
# We use ADF test to check if our ts has trend or is stationary. If p<0.05 => It's stationary
adf.test(irl_import_yearly)  # p-value = 0.53 > 0.05 => Our data has trend

# Check for Cycles in our data
plot(hpfilter(irl_import_yearly))

# We use 4 models : naive, holts, ets, and arima model

# Naive Model
naive_yearly <- naive(irl_import_yearly, h=1)
summary(naive_yearly)
autoplot(naive_yearly)
checkresiduals(naive_yearly)

# Holts Model
holt_yearly <- holt(irl_import_yearly, h=1)
summary(holt_yearly)
autoplot(holt_yearly)
checkresiduals(holt_yearly$residuals)

# ETS Model
ets_yearly <- ets(irl_import_yearly, model = "ZZN")
summary(ets_yearly)
autoplot(ets_yearly$fitted)
checkresiduals(ets_yearly)

# ARIMA Model
# check for  differencing needed or not
paste("No. of differencing needed: ", ndiffs(irl_import_yearly))
irl_import_yearly_diff <- diff(irl_import_yearly)
autoplot(irl_import_yearly_diff, ylab = "Differenced Import in EUR(millions)") # Done differencing
# autoplot(diff(irl_import_yearly_diff)) # Double differencing
paste("No. of differencing needed: ", ndiffs(irl_import_yearly_diff))
# Check if our data is stationary now using adf.test
adf.test(irl_import_yearly_diff) # p = 0.3587 => Indicates that there is still a trend in the data
irl_import_yearly_diff_2 <- diff(irl_import_yearly_diff)
adf.test(irl_import_yearly_diff_2) # p = 0.04019 => Indicates that our data is stationary
ggtsdisplay(irl_import_yearly)
ggtsdisplay(irl_import_yearly_diff)
ggtsdisplay(irl_import_yearly_diff_2)
# We move forward anyway

arima_yearly <- Arima(irl_import_yearly, order = c(1,1,0)) # From ggtsdisplay()
summary(arima_yearly)
frcast_arima <- forecast(arima_yearly, h=3)
autoplot(frcast_arima)
checkresiduals(arima_yearly)

#### NEW ARIMA ####

ar111 <- Arima(irl_import_yearly, order = c(1,1,1))
summary(ar111)
checkresiduals(ar111)

ar011 <- Arima(irl_import_yearly, order = c(0,1,1))
summary(ar011)
checkresiduals(ar011)

ar110 <- Arima(irl_import_yearly, order = c(1,1,0))
summary(ar110)
checkresiduals(ar110)

ar222 <- Arima(irl_import_yearly, order = c(2,2,2))
summary(ar222)
checkresiduals(ar222)

ar220 <- Arima(irl_import_yearly, order = c(2,2,0))
summary(ar220)
checkresiduals(ar220)

ar022 <- Arima(irl_import_yearly, order = c(0,2,2))
summary(ar022)
checkresiduals(ar022)
fcast_arima <- forecast(ar022, h=3)
print(fcast_arima)
autoplot(fcast_arima)

arauto <- auto.arima(irl_import_yearly)
summary(arauto)
checkresiduals(arauto)

# 110, 111, 011, 220, 222, 022, 011_auto
r_names <- c("arima_110", "arima_111", "arima_011", "arima_220", "arima_222", "arima_022", "autoarima_011")
aic_values <- c(615.25, 616.96, 614.97, 603.11, 602.72, 597.26, 613.07)
rmse_values <- c(4505.078, 4445.895, 4481.847, 4820.448, 4165.575, 4182.855, 4183.375)

arima_df <- data.frame(aic_values, rmse_values, r_names, row.names = r_names)

ggplot(arima_df, mapping = aes(x=r_names, y=aic_values, group = 1)) + geom_line(aes(color="red")) + geom_point(aes(color="red")) + labs(title="Summary of 7 ARIMA Models fit",x="Models", y = "AICc Measures of Arima models")
ggplot(arima_df, mapping = aes(x=r_names, y=rmse_values, group = 1)) + geom_line(color="blue") + geom_point(color="blue") + labs(title="Summary of 7 ARIMA Models fit",x="Models", y = "RMSE Measures of Arima models")

temperatureColor <- "#69b3a2"
priceColor <- rgb(0.2, 0.6, 0.9, 1)
ggplot(arima_df, aes(x=r_names)) +
  
  geom_line( aes(y=aic_values), size=2, color=temperatureColor) + 
  geom_line( aes(y=rmse_values), size=2, color=priceColor) +
  
  scale_y_continuous(
    
    # Features of the first axis
    name = "AICc Measures of Arima models",
    
    # Add a second axis and specify its features
    sec.axis = sec_axis(~.*rmse_values, name="RMSE Measures of Arima models")
  ) + 
  
  theme_ipsum() +
  
  theme(
    axis.title.y = element_text(color = temperatureColor, size=13),
    axis.title.y.right = element_text(color = priceColor, size=13)
  ) +
  
  ggtitle("Summary of 7 ARIMA Models fit")


#### END NEW ARIMA ####