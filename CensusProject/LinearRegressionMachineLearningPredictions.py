import pandas as pd
from sklearn import linear_model
import numpy as np

df = pd.read_csv('census.csv')
#print(df)


x = df[['CollegeGradRatioState', 'Total_Insured']]
y = df['Median_earnings']

model = linear_model.LinearRegression()

model.fit(x,y)
num_samples = 1000
np.random.seed(42)
random_college = np.random.randint(low=14.175,high=27.38, size = num_samples)
random_insurance = np.random.randint(low=82.03,high=97.50, size = num_samples)

new_df = pd.DataFrame({'CollegeGradRatioState':random_college, 'Total_Insured': random_insurance})

predictions = model.predict(new_df)

results = pd.concat([new_df, pd.Series(predictions, name='PredictedEarnings')], axis=1)
print(results)

results.to_csv('predicted_earnings.csv', index=False)
