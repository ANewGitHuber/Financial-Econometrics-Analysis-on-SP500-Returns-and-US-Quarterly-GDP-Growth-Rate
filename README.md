## Financial-Econometrics-Analysis-on-SP500-Returns-and-US-Quarterly-GDP-Growth-Rate

This project provides financial econometrics analysis on:

S&P-500 Returns (Jan 1980 - Dec 2008)

US Quarterly GDP Growth Rate (Q1 1955 - Q4 2004)

### Packages
library(readxl)
library(stats)
library(sandwich)
library(lmtest)
library(rugarch)
library(fGarch)
library(dplyr)
library(forecast)
library(fUnitRoots)

Use install.packages("") to install the libraries if you haven't done so yet.

### Econometrics Methodologies in the Project
- Multiple Linear Regression Model

Provides modelling on the Weekday Effects.
![image](https://github.com/ANewGitHuber/Financial-Econometrics-Analysis-on-SP500-Returns-and-US-Quarterly-GDP-Growth-Rate/assets/88078123/d15de6a8-0ba7-474d-a9af-f54543b09589)

- Newey West Estimator Analysis

Provides consistent standard errors for coefficient estimates in the presence of heteroskedasticity and autocorrelation. The estimator adjusts the covariance matrix of the coefficient estimates to account for these issues, thus improving the reliability of hypothesis testing.

Var(\hat{\beta})_{NW} = (X'X)^{-1} \left( \sum_{t=1}^{T} \epsilon_t^2 X_t X_t' + \sum_{l=1}^{L} w_l \sum_{t=l+1}^{T} \epsilon_t \epsilon_{t-l} (X_t X_{t-l}' + X_{t-l} X_t') \right) (X'X)^{-1}

where:

- `Var(\hat{\beta})_{NW}` is the Newey-West adjusted covariance matrix.
- `X'X` is the product of the matrix of independent variables and its transpose.
- `\epsilon_t` is the residual at time `t`.
- `L` is the chosen lag length.
- `w_l` are the weights assigned to the lagged terms.


- Autoregressive Conditional Heteroskedasticity (ARCH(1) Model)

Describes and predicts time series data, particularly the volatility of financial time series.
![image](https://github.com/ANewGitHuber/Financial-Econometrics-Analysis-on-SP500-Returns-and-US-Quarterly-GDP-Growth-Rate/assets/88078123/86c1cc84-3919-47dd-8abf-584c07fa8637)

- Generalized Autoregressive Conditional Heteroskedasticity (GARCH(1,1) Model)

Used in financial econometrics to model time series data, particularly for capturing the volatility (time-varying variance) of financial returns.
![image](https://github.com/ANewGitHuber/Financial-Econometrics-Analysis-on-SP500-Returns-and-US-Quarterly-GDP-Growth-Rate/assets/88078123/f174f5a9-b198-499f-be37-c33565f547e4)

- Autoregression Analysis

A time series model used to explore the correlation between a time series and its lagged values. It helps in understanding if there’s a relationship between the current observation and previous observations within the same series.
![image](https://github.com/ANewGitHuber/Financial-Econometrics-Analysis-on-SP500-Returns-and-US-Quarterly-GDP-Growth-Rate/assets/88078123/72c4f913-3929-4590-a2c9-c8126670cec1)

- Autoregression Model of Order 1 (AR(1) Model)

Explains a variable in terms of its own previous value. Characterized by a single lagged term of the variable.
![image](https://github.com/ANewGitHuber/Financial-Econometrics-Analysis-on-SP500-Returns-and-US-Quarterly-GDP-Growth-Rate/assets/88078123/d41e3e74-6071-4c05-a478-012b26154270)

- Autoregressive Model of Order 2 (AR(2) Model)

A time series model where the current value of the series is explained by its own two previous values. This model is useful when the data shows evidence of being influenced by the last two periods.
![image](https://github.com/ANewGitHuber/Financial-Econometrics-Analysis-on-SP500-Returns-and-US-Quarterly-GDP-Growth-Rate/assets/88078123/689c6ca0-cddc-4fd3-8dad-54fa5de034f6)

- Bayesian Information Criterion (BIC) Model Selection

A criterion for model selection among a finite set of models. It is based on the likelihood function and is used extensively in statistical model fitting.
![image](https://github.com/ANewGitHuber/Financial-Econometrics-Analysis-on-SP500-Returns-and-US-Quarterly-GDP-Growth-Rate/assets/88078123/3e32e435-e2ba-405f-adee-9187faf2c335)

- Akaike Information Criterion (AIC) Model Selection

A criterion used to compare different models and select the one that best explains the data while avoiding overfitting. It balances the model’s complexity against its goodness of fit.
![image](https://github.com/ANewGitHuber/Financial-Econometrics-Analysis-on-SP500-Returns-and-US-Quarterly-GDP-Growth-Rate/assets/88078123/3ceed666-00a3-4f5e-9e5f-d4507a20ea3d)
![image](https://github.com/ANewGitHuber/Financial-Econometrics-Analysis-on-SP500-Returns-and-US-Quarterly-GDP-Growth-Rate/assets/88078123/d74c566d-c180-471c-9dd1-285a04122107)
![image](https://github.com/ANewGitHuber/Financial-Econometrics-Analysis-on-SP500-Returns-and-US-Quarterly-GDP-Growth-Rate/assets/88078123/d3bd8d79-38d1-412f-a41d-3b93175f3330)

- Augmented Dickey-Fuller (ADF) Test

Tests for a unit root in the time series. This test can help determine whether a time series is stationary or not, which is a critical aspect of many time series analyses, including AR modelling.
![image](https://github.com/ANewGitHuber/Financial-Econometrics-Analysis-on-SP500-Returns-and-US-Quarterly-GDP-Growth-Rate/assets/88078123/4cd385a0-1983-403f-89fb-45a200818137)

See report PDF for full descriptions.

@John Chen, 2023, Imperial College London. All rights to source codes are reserved.
