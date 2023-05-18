import statsmodels.api as sm
import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv('census.csv')


x = df[['CollegeGradRatioState', 'Total_Insured']]
y = df['Median_earnings']


"""
x = df[['Median_earnings', 'Total_Insured']]
y = df['CollegeGradRatioState']
"""

"""
x = df[['CollegeGradRatioState', 'Median_earnings']]
y = df['Total_Insured']
"""

# Fit the linear regression model
model = sm.OLS(y, x).fit()

# residuals
residuals = model.resid


# Creating normality plot
sm.qqplot(residuals, line='s')
plt.xlabel('Theoretical Quantiles')
plt.ylabel('Standardized Residuals')
plt.title('Normality Plot')
plt.show()

residuals = model.resid

# Creating residual plots
plt.scatter(y, residuals)
plt.axhline(y=0, color='r', linestyle='--')
plt.xlabel('Predicted Values')
plt.ylabel('Residuals')
plt.title('Residual Plot')
plt.show()
