# Statistical Time Series Analysis for Irish import trade Data and Forecasting

**Experience Level:** Intermediate - Advance

**Technology Used:** R

---

#### Summary of the Experiment:

1. The aim of the experiment was to perform forecasting on Ireland import trade in EUR(million) for 3 consecutive years of 2020, 2021, and 2022.
2. Steps from visually understanding the time-series data, checking for various components in the series, fitting different models to the data to comparing and evaluating the models and finally forecasting using a selected models are performed in the experiment.
3. Checks are performed for time-series components such as trend, seasonality and cycles using statistical tests for each component.
    1. Based on components present particular suited models are selected to fit the data
4. Four models were selected to fit the time series data were Naive model, Holts model, ETS model, ARIMA model.
    1. All the models are evaluated and compared on the AICc and RMSE metrics
    2. Best among all the models is selected for forecasting
5. Before performing the forecast model is first evaluated using statistical tests for no residual correlation (Ljung-Box test) and residual plot and ACF plot to check goodness of fit.
6. Three Forecasts are then made using the selected ARIMA 022 model.

---

**Objectives:**
* To fit a time-series model to perform forecast for Ireland import trade for years 2020, 2021, and 2022.
* To vizualize the time-series data for basic understanding
* To perform checks using statistical tests for components of time-series
* To fit, compare the time-series models on the trade data and select the model to perform forecasting.
* To check Goodness of fit using statistical test and techniques

### Data Description:

Time Series Data of Ireland import trade (millions of EUR) every year from 1988-2019 (31 periods)

### Plotting the Time-Series for visual interpretation:

![alt text](https://github.com/Padlu/Statistical-Analysis-Logistic-Regression-Time-Series-and-Principal-Component-Analysis-Project/blob/main/Images/TS_plot.png "Ireland Import Trade (1988-2019)")

> * The plot shows clear pattern of an upward trend => Series is not stationary
> * Expected to have no seasonal component because of the yearly data
> * Interpretation is that the series possess some extent of trend in it => No need to smooth it using moving averages technique

### Statistical Tests to check Time-Series Components in the data:

1. Trend:
![alt text](https://github.com/Padlu/Statistical-Analysis-Logistic-Regression-Time-Series-and-Principal-Component-Analysis-Project/blob/main/Images/TS_Trend_test.png "Augmented Dickey-Fuller(ADF) Test for Trend")

> * Augmented Dickey-Fuller(ADF) test with significant p-value >0.05 implies that the dataset has a trend component to it.

2. Seasonality:

![alt text](https://github.com/Padlu/Statistical-Analysis-Logistic-Regression-Time-Series-and-Principal-Component-Analysis-Project/blob/main/Images/TS_Seasonal_Test.png "Seasonal Decomposition in R")

> * Seasonal plot function in R for decomposition confirms no seasonality component in the data.
> * Confirms our prior expectation about this part 

3. Cycles:

![alt text](https://github.com/Padlu/Statistical-Analysis-Logistic-Regression-Time-Series-and-Principal-Component-Analysis-Project/blob/main/Images/TS_Cycle_test.png "Hodrick-Prescott Filter Test for Cycles")

> * Cyclic components can be seend by looking at any cyclic pattern with respect to the trend line.
> * Using Hodrick-Prescott Filter, a cyclical component deviating from the trend line is seen.


1. These tests and methods confirms a trend and cyclical components in the time-series data
2. Thus, Holts model, an ETS model, and an ARIMA model is selected to fit this data. Also, Näive model is selected to check how well the other sophisticated models perform in comparison.


### Modeling the Time Series Data:

Summary Points for models.

ARIMA models.

Tables showing Comparison.

Comparison points.


### Evaluation of Chosen ARIMA 022 Model:


![alt text](https://github.com/Padlu/Statistical-Analysis-Logistic-Regression-Time-Series-and-Principal-Component-Analysis-Project/blob/main/Images/lb_a022.png "Ljung-Box test of Autocorrelation")

![alt text](https://github.com/Padlu/Statistical-Analysis-Logistic-Regression-Time-Series-and-Principal-Component-Analysis-Project/blob/main/Images/AIC_RMSE_Arima.png "ACF and Residual plot of ARIMA 022")


### Forecasting the Ireland Import Trade for 2020,21, and 22 using ARIMA 022:


![alt text](https://github.com/Padlu/Statistical-Analysis-Logistic-Regression-Time-Series-and-Principal-Component-Analysis-Project/blob/main/Images/Forecasts_ARIMA022.png "Model Forecast with CI of 80% and 95%")

---

Time-Series Analysis Experiment Project by [Abhishek Padalkar](https://github.com/Padlu).
