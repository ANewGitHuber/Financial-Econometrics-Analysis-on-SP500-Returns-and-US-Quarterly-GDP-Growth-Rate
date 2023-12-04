library(readxl)
library(stats)
library(sandwich)
library(lmtest)
library(rugarch)
library(fGarch)
library(dplyr)
library(forecast)
library(fUnitRoots)

# Read the dataset
data_US <- read_excel("USMacro_Quarterly.xls")

# Convert "Date" to a year-quarter format
data_US$Date <- as.yearqtr(data_US$Date, format = "%Y:%q")

# Calculate the logarithm of Real GDP
# Calculate the quarterly growth rate of GDP (ΔY(t))
data_US <- data_US %>%
  mutate(Log_RealGDP = log(RealGDP)) %>%
  mutate(GDP_Growth_Rate = Log_RealGDP - lag(Log_RealGDP))

# Filter for the sample period from 1955:1 to 2004:4
start_period <- as.yearqtr("1955 Q1", format = "%Y Q%q")
end_period <- as.yearqtr("2004 Q4", format = "%Y Q%q")
sample_data <- data_US %>%
  filter(Date >= start_period & Date <= end_period)

# Compute the mean of the GDP Growth Rate (na.rm=TRUE to ignore NA values)
mean_gdp_growth_rate <- mean(sample_data$GDP_Growth_Rate, na.rm = TRUE)
mean_gdp_growth_rate

# Get the mean growth rate in percentage points at annual rate
annual_mean_gdp_growth_rate <- mean_gdp_growth_rate * 400
annual_mean_gdp_growth_rate

# Compute the standard deviation of the GDP Growth Rate (ΔY(t))
std_dev_gdp_growth_rate <- sd(sample_data$GDP_Growth_Rate, na.rm = TRUE)

# Convert the result in % points at annual rate
annual_std_dev_gdp_growth_rate <- std_dev_gdp_growth_rate * 400
annual_std_dev_gdp_growth_rate

# The autocorrelations of ΔY(t)
autocorrelations <- Acf(sample_data$GDP_Growth_Rate, lag.max = 4, plot = T)

# Find the first four autocorrelations
autocorr_4 <- autocorrelations$acf[2:5]
autocorr_4

# Fit the AR(1)
ar1_model <- arima(sample_data$GDP_Growth_Rate, order=c(1,0,0))
ar1_model

summary(ar1_model)

# Extract the estimated AR(1) coefficient
ar1_coefficient <- ar1_model$coef[1]
ar1_coefficient

# Extract standard error from the model
ar1_se <- sqrt(diag(vcov(ar1_model)))[1]

# Calculate the t-statistic
t_statistic_ar1 <- ar1_coefficient / ar1_se
t_statistic_ar1

# Calculate the degrees of freedom for the t-distribution
df <- length(sample_data$GDP_Growth_Rate) - ar1_model$arma[1] - 1

# Calculate the two-tailed p-value
p_value_ar1 <- 2 * pt(-abs(t_statistic_ar1), df)
p_value_ar1

# Fit the AR(2)
ar2_model <- arima(sample_data$GDP_Growth_Rate, order=c(2,0,0))
ar2_model

# Extract the estimated coefficients for the two lags
ar2_coefficient <- ar2_model$coef[2]
ar2_coefficient

# Extract standard error from the model
ar2_se <- sqrt(diag(vcov(ar2_model)))[2]

# Calculate the t-statistic
t_statistic_ar2 <- ar2_coefficient / ar2_se
t_statistic_ar2

# Calculate the degrees of freedom for the t-distribution
df <- length(sample_data$GDP_Growth_Rate) - ar2_model$arma[1] - 1

# Calculate the two-tailed p-value
p_value_ar2 <- 2 * pt(-abs(t_statistic_ar2), df)
p_value_ar2

# Fit the AR(3)
ar3_model <- arima(sample_data$GDP_Growth_Rate, order=c(3,0,0))
ar3_model

# Fit the AR(4)
ar4_model <- arima(sample_data$GDP_Growth_Rate, order=c(4,0,0))
ar4_model

# Extract BIC values
bic_values <- c(BIC(ar1_model),
                BIC(ar2_model),
                BIC(ar3_model),
                BIC(ar4_model))
bic_values

# Determine the optimal number of lags
optimal_lags_bic <- which.min(bic_values)
optimal_lags_bic

# Extract BIC values
aic_values <- c(AIC(ar1_model),
                AIC(ar2_model),
                AIC(ar3_model),
                AIC(ar4_model))
aic_values

# Determine the optimal number of lags
optimal_lags_aic <- which.min(aic_values)
optimal_lags_aic

# Applying the ADF test
adfTest(sample_data$GDP_Growth_Rate,lags = 1,type = c("c"))

# Fit an ARCH(1) model
arch_GDP <- garchFit(~ garch(1, 0), 
                     data = sample_data$GDP_Growth_Rate, trace = FALSE)
summary(arch_GDP)

# Fit a GARCH(1,1) model
garch_GDP <- garchFit(~ garch(1, 1), 
                      data = sample_data$GDP_Growth_Rate, trace = FALSE)
summary(garch_GDP)

# Extract coefficients for ARCH(1) model and 
# Compute the unconditional variance
omega_arch_GDP <- coef(arch_GDP)["omega"]
alpha_arch_GDP <- coef(arch_GDP)["alpha1"]
uncond_var_arch_GDP <- omega_arch_GDP / (1 - alpha_arch_GDP)

# Extract the coefficients for GARCH(1,1) model and 
# Compute the unconditional variance
omega_garch_GDP <- coef(garch_GDP)["omega"]
alpha_garch_GDP <- coef(garch_GDP)["alpha1"]
beta_garch_GDP <- coef(garch_GDP)["beta1"]
uncond_var_garch_GDP <- omega_garch_GDP / 
  (1 - alpha_garch_GDP - beta_garch_GDP)

# Print the unconditional variance for the two models
round(uncond_var_arch_GDP,6)
round(uncond_var_garch_GDP,6)