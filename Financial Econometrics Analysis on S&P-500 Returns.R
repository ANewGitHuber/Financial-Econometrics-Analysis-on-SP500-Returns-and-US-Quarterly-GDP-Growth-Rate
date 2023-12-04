library(readxl)
library(stats)
library(sandwich)
library(lmtest)
library(rugarch)
library(fGarch)
library(dplyr)
library(forecast)
library(fUnitRoots)

data <- read_excel("SP500WeekDays.xlsx")
data <- na.omit(data)

# The dependent variable: S&P 500 daily returns
y <- data$sp

# The independent variable: indicators for the weekdays
X <- data[, c('M', 'T', 'W', 'R', 'F')]

# Fit the linear regression model
model <- lm(y ~ M + T + W + R + F, data = data)

# This shows the summary of the model
summary(model)

# Refit the model
model_refit <- lm(y ~ M + T + W + R, data = data)
summary(model_refit)

# Extract the p-values
p_values <- coef(summary(model_refit))[, "Pr(>|t|)"]
p_values

# Calculate Newey-West standard errors
nw_se <- NeweyWest(model_refit)

#Use coeftest to get t-ratio with Newey-West standard errors
t_ratio <- coeftest(model, vcov = nw_se)
t_ratio

# Calculate the log returns
log_returns <- log(1 + data$sp)
log_returns <- na.omit(log_returns)

# Fit an ARCH(1) model
arch <- garchFit(~ garch(1, 0), data = log_returns, trace = FALSE)
summary(arch)

# Fit a GARCH(1,1) model
garch <- garchFit(~ garch(1, 1), data = log_returns, trace = FALSE)
summary(garch)

# Extract coefficients for ARCH(1) model and 
# Compute the unconditional variance
omega_arch <- coef(arch)["omega"]
alpha_arch <- coef(arch)["alpha1"]
uncond_var_arch <- omega_arch / (1 - alpha_arch)

# Extract the coefficients for GARCH(1,1) model and
# Compute the unconditional variance
omega_garch <- coef(garch)["omega"]
alpha_garch <- coef(garch)["alpha1"]
beta_garch <- coef(garch)["beta1"]
uncond_var_garch <- omega_garch / (1 - alpha_garch - beta_garch)

# Print the unconditional variance for the two models
round(uncond_var_arch,6)
round(uncond_var_garch,6)