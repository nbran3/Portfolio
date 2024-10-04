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
Cluster 0 represents the largest population group in the segmentation. This cluster is characterized by individuals predominantly born in the 1970s, placing them in their mid-40s to early 50s. They belong mostly to the second-lowest income bracket and over 60% hold some form of college degree, indicating a strong emphasis on education.

In terms of family dynamics, many in this cluster have children, yet the majority are single rather than married or divorced, possibly reflecting single parents or individuals living alone with dependents. Despite their modest income, members of this cluster are notably not big spenders, with the total sum spent on goods across categories being relatively low.

However, what sets this cluster apart is its exceptional response to Campaign 3, with a 75% acceptance rate—a figure unmatched by any other cluster across any campaign. This high engagement suggests they may be particularly receptive to certain types of offers or promotions, making them a key target for future marketing strategies.

