import pandas as pd
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt
import numpy as np
import statsmodels.api as sm

earn = pd.read_csv('earnings.csv')
edu = pd.read_csv('education.csv')
health = pd.read_csv('health.csv')

earnhealth = pd.merge(earn, health, on ='State')

X = earnhealth[['Median_earnings','Total_Insured']]
y = edu['CollegeGradRatioState']
X = sm.add_constant(X)

# Performing multiple linear regression
model = sm.OLS(y, X).fit()

# Printing the regression summary
print(model.summary())

y_pred = model.predict(X)

# Plotting the actual values
plt.scatter(y, y, color='blue', label='Actual')

# Plotting the predicted values
plt.scatter(y, y_pred, color='red', label='Predicted')
plt.plot(y, y_pred, color='green', label='Regression Line')


# Adding labels and title
plt.xlabel('Actual Values')
plt.ylabel('Predicted Values')
plt.title('Multiple Linear Regression')

# Adding legend
plt.legend()

# Display the plot
plt.show()
