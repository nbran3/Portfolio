import matplotlib.pyplot as plt
import pandas as pd

###Preparing dataframe for analysis
df = pd.read_csv('census.csv')
#print(df)

ear = df['Median_earnings']
edu = df['CollegeGradRatioState']
health = df['Total_Insured']


### Creating histograms
plt.hist(ear, color='green')
#plt.show()

plt.hist(edu)
#plt.show()

plt.hist(health, color = 'red')
#lt.show()




### Correlation between median earnings and ratio of college graduates in state  and scatter graph
earedu = ear.corr(edu)
#print(earedu)
### Result is .76
plt.scatter(ear, edu, color = 'teal')
plt.title('Scatter of Median Earnings and Proportion of College Graduates to State Pop')
plt.xlabel("Median Earnings")
plt.ylabel('College Grad Ratio')
#plt.show()




### Correlation between median earnings and ratio of people insured and scatter graph
earhealth = ear.corr(health)
#print(earhealth)
### Result is .51
plt.scatter(edu, health, color = 'purple')
plt.title('Scatter of Proportion of State that is insured and Median earnings')
plt.xlabel("Median Earnings")
plt.ylabel('Total Insured Ratio')
#plt.show()




### Correlation between ratio of college grads and ratio of people insured and scatter graph
eduhealth = edu.corr(health)
#print(eduhealth)
### Result is .36
plt.scatter(ear, health, color = 'darkgoldenrod')
plt.title('Scatter of Proportion of State that is insured and Proportion of College Graduates to State Pop')
plt.xlabel("Total Insured Ratio")
plt.ylabel('College Grad Ratio')
#plt.show()
