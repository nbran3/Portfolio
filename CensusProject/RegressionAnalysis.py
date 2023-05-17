import numpy as np
import pandas as pd
from sklearn.linear_model import LinearRegression
import statsmodels.api as sm
import matplotlib.pyplot as plt

earn = pd.read_csv('earnings.csv')
edu = pd.read_csv('education.csv')
health = pd.read_csv('health.csv')

X = earn['Median_earnings'].values.reshape(-1,1)
y = edu['CollegeGradRatioState'].values.reshape(-1,1)
z = health['Total_Insured'].values.reshape(-1,1)
a = health['Total_Uninsured'].values.reshape(-1,1)


"""
###Earnings and Education Regression
model = LinearRegression()

model.fit(X,y)

y_pred = model.predict(X)

x = sm.add_constant(X)
model = sm.OLS(y,x)
results = model.fit()
"""

"""
### Education and Total Insured Regression
model = LinearRegression()

model.fit(y,z)

z_pred = model.predict(y)

y = sm.add_constant(y)
model = sm.OLS(z,y)
results = model.fit()
"""

coefficients = results.params
rsqaured = results.rsquared
p_values = results.pvalues

print("Coefficients:")
print(coefficients)
print("\nR-squared:")
print(rsqaured)
print("\nP-values:")
print(p_values)

plt.scatter(z,z_pred)
plt.xlabel("Actual values")
plt.ylabel("Predicted Values")
plt.title('Regression Analysis')
plt.show()
