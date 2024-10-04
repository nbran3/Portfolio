Below is a summary of the project.

I found this dataset on Kaggle. I do not believe this is real data, but the data is still something that I believe could be great pratice for a real-world situtation. The point of this project was to find trends and similarties of customers with similar demographic data into clusters 
which could lead to better informed decisions. 
I first did EDA or exploratory analysis in SQL just to get a feel of the data.
Afterwards I preprocessed the data in Python, because the demographic data was mostly in strings or a wide number of integers, I decided because the project was a clustering project to put the following variables into bins including: Education Levels (4 bins, ranging from HS Diploma or Basic, Undergraduate or Graduate,
Master and 2n Cycle, and PhD), Income (4 bins, >$24,999, $25,000-$39,000, $40,000-$59,999, $60,000-$79,999 and <$80,000), Marital Status (4 bins, Single, Together, Married, Widowed and Divorced), amd lastly Age (5 bins ranging from 1940 and before to 1952, 1953 to 1965, 1966 to 1980, 1981 to 1996 and 1997 to present.
There was one other demographic data in the dataset regarding if the household or user had children or teens, I decided to just combined both of them into one catergory so if they had either or they would check the box because I did not think the shopping habits would differ that much for the majoirty of users simply 
because of the age of their child when the most popular product in the dataset is Wine by far. Those were the demographic data or features I used to model the clusters, to recap it was Education, Income, Age, Marital Status and Children in the household.

I then went to a new notebook for the model because the data preprocessing one was rather long already, because the data was already preproccesed I could pretty much jump right into it, but had to decide on how many clusters to run, after running an elbow method I decided between 4 and 5 and after reviewing both
4 was the obvious winner, I will provide both below : ![image](https://github.com/user-attachments/assets/4cc11d9e-2ec5-4319-aa08-e95e93d108ce) ![image](https://github.com/user-attachments/assets/3e0e5fee-3332-414d-b121-03c2bc8850e6)
 
As you can see above four clusters make it much more readable and accessbile, the model had a hard time clustering the difference between 4/Orange Cluster and the 3/Purple Cluster, I did not dive into the data for the Orange Cluster, but as for the Purple Cluster these people were all in the oldest or
second oldest age bracket, the vast majority were either in the second highest income income bracket and then the highest bracket and were heavily married or with a partner, no children in the household due to age, 
the only thing I can see from the data is that it was either trying to segment on age or maybe marital status between the Orange and Purple Cluster, but was failing due to simply not enough people in population.  

Now I will dive into the data of each Segment : 

First is Segment 0 or the Red Cluster - ![image](https://github.com/user-attachments/assets/79a8bae7-40dd-4787-8dbd-fbf1a7a05d0b)
This is highest population cluster and is a bit hard to quantify exactly but the majority of people were born in the 1970s, were in the second lowest income bracket, over 60% were college graduates in some form, had children but were mostly single and not divorced. I am not sure how to quantify this population exactly 
other than middle-income, educated, and family-oriented but single. They are also not huge spenders with sum of goods across the board much lower, due to the lower income distribution and but accepted Campaign 3 at a whopping 75%, which no other cluster in any campaign even comes close 
