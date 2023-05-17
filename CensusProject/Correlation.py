import matplotlib.pyplot as plt
import numpy as np
import matplotlib
import pandas as pd
import seaborn as sns

earn = pd.read_csv('earnings.csv')
health = pd.read_csv('health.csv')
edu = pd.read_csv('education.csv')

x = earn['Median_earnings']
y = edu['CollegeGradRatioState']
z = health['Total_Insured'].astype(float)
a = health['Total_Uninsured'].astype(float)

###earnhealth = x.corr(y)
###print(earnedu)
# Result -.02

plt.scatter(x,y)
plt.xlabel("Median Earnings")
plt.ylabel('College Graduate Ratio')
plt.title("Scatter Plot : Earnings vs College Grad Ratio")
plt.show()


###earnhealth = x.corr(z)
###print(earnhealth)
# Result -.02

###earnunisured = x.corr(a)
###print(earnunisured)
### Result .02

###eduinsured = y.corr(a)
###print(eduuninsured)
###Result -.36


plt.scatter(y,a, color = 'red')
plt.xlabel("College Graduate Ratio")
plt.ylabel('Total Uninsured')
plt.title("Scatter Plot : Total_Uninsured vs College Grad Ratio")
plt.show()



###eduhealth = y.corr(z)
###print(eduinsured)
## Result .36

plt.scatter(y,z, color = 'teal')
plt.xlabel("College Graduate Ratio")
plt.ylabel('Total Insured')
plt.title("Scatter Plot : Total_Insured vs College Grad Ratio")
plt.show()
