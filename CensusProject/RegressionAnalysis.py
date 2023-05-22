import pandas as pd
from sklearn.linear_model import LinearRegression
import statsmodels.api as sm
import matplotlib.pyplot as plt

df = pd.read_csv('census.csv')
#print(df)

ear = df['Median_earnings']
edu = df['CollegeGradRatioState']
health = df['Total_Insured']

x = ear.values.reshape(-1,1)
y = edu.values.reshape(-1,1)
z = health.values.reshape(-1,1)


model = LinearRegression()
model.fit(x,y)
x = sm.add_constant(x)
model = sm.OLS(y,x)
results = model.fit()
print(results.summary())



model = LinearRegression()
model.fit(x,z)
x = sm.add_constant(x)
model = sm.OLS(z,x)
results = model.fit()
print(results.summary())

