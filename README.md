### Financial-Econometrics-Analysis-on-SP500-Returns-and-US-Quarterly-GDP-Growth-Rate

This project provides financial econometrics analysis on:
S&P-500 Returns (Jan 1980 - Dec 2008)
US Quarterly GDP Growth Rate (Q1 1955 - Q4 2004)

## Packages
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

## Econometrics Methodologies in this Project
- Multiple Linear Regression Model

It provides modelling on the Weekday Effects

- Newey West Estimator Analysis

It provides consistent standard errors for coefficient estimates in the presence of heteroskedasticity and autocorrelation.The estimator adjusts the covariance matrix of the coefficient estimates to account for these issues, thus improving the reliability of hypothesis testing.
![image](https://github.com/ANewGitHuber/Financial-Econometrics-Analysis-on-SP500-Returns-and-US-Quarterly-GDP-Growth-Rate/assets/88078123/177caff9-529f-4dcf-a07c-353b4909aef2)

- Autoregressive Conditional Heteroskedasticity (ARCH)
- 







