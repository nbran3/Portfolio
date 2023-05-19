#This was for fun this is not part of the overal/ project
import pandas as pd
import statsmodels.api as sm
import matplotlib.pyplot as plt

df = pd.read_csv('census.csv')
#print(df)

"""
x = df[['CollegeGradRatioState', 'Total_Insured']]
y = df['Median_earnings']
"""

"""
x = df[['Median_earnings', 'Total_Insured']]
y = df['CollegeGradRatioState']
"""

x = df[['CollegeGradRatioState', 'Median_earnings']]
y = df['Total_Insured']


model = sm.OLS(y,x).fit()
predicted = model.predict()
print(model.summary())

plt.scatter(predicted, y, c='b')
plt.legend()
plt.show()
