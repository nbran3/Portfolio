Below is a summary of the project.

This project focuses on clustering customers based on demographic data, using the insights to inform marketing strategies. The data, found on Kaggle, offers a hypothetical yet realistic practice scenario to uncover trends in customer behavior and characteristics. I first did EDA or exploratory analysis in SQL just to get a feel of the data. Afterward, I preprocessed the data in Python, because the demographic data was mostly in strings or a wide number of integers, To make the data more manageable for clustering, I grouped key demographic features such as Education, Income, Age, Marital Status, and Children into bins. For instance, income was grouped into four ranges, education into levels (from high school to PhD), and age into generational brackets. There was one other demographic data in the dataset regarding whether the household or user had children or teens, I decided to just combine both of them into one category so if they had either they would check the box because I did not think the shopping habits would differ that much for the majority of users simply because of the age of their child when the most popular product in the dataset is Wine by far. Those were the demographic data or features I used to model the clusters, to recap it was Education, Income, Age, Marital Status, and Children in the household.

I then went to a new notebook for the model because the data preprocessing one was rather long already, because the data was already preprocessed I could pretty much jump right into it, but I had to decide on how many clusters to run, after running an elbow method I decided between 4 and 5 and after reviewing both
4 was the obvious winner, I will provide both below:![image](https://github.com/user-attachments/assets/4cc11d9e-2ec5-4319-aa08-e95e93d108ce) ![image](https://github.com/user-attachments/assets/3e0e5fee-3332-414d-b121-03c2bc8850e6)
 
As you can see above four clusters make it much more readable and accessible, the model had a hard time clustering the difference between the 4/Orange Cluster and the 3/Purple Cluster. I did not dive into the data for the Orange Cluster, but as for the Purple Cluster these people were all in the oldest or
second oldest age bracket, the vast majority were either in the second highest income bracket and then the highest bracket and were heavily married or with a partner, had no children in the household due to age, 
the only thing I can see from the data is that it was either trying to segment on age or maybe marital status between the Orange and Purple Cluster, but was failing due to simply not enough people in the population.  

Now I will dive into the data of each Segment : 

First is Cluster 0 or the Red Cluster -![image](https://github.com/user-attachments/assets/32779746-b909-45bc-a9be-99e7110b3007)

Cluster 0 represents the second-largest population group in the segmentation. This cluster is characterized by individuals predominantly born in the 1970s, placing them in their mid-40s to early 50s, but is the most wide-ranging population with some members being born in the 1950s and even one person being born in 2000. They belong mostly to the second-lowest or lowest income bracket and over 60% hold some form of college degree, indicating a strong emphasis on education.

In terms of family dynamics, many in this cluster have children, yet the majority are single rather than married or divorced, possibly reflecting single parents or individuals living alone with dependents. Despite their modest income, members of this cluster are notably not big spenders, with the total sum spent on goods across categories being lower than in smaller populated clusters. This cluster is more modest in both income and spending habits compared to others. 

However, what sets this cluster apart is its exceptional response to Campaign 3, with a 75% acceptance rate—a figure unmatched by any other cluster across any campaign. This high engagement suggests they may be particularly receptive to certain types of offers or promotions, making them a key target for future marketing strategies.

Next is Cluster 1 or the Blue Cluster -![image](https://github.com/user-attachments/assets/b7fa14bf-c036-4e6e-8692-fd267d625e61)
Cluster 1 represents the largest population group in this segmentation, capturing a different side of Generation X compared to Cluster 0. This cluster is dominated by suburban family households, with members primarily born in the 1970s, though slightly older on average than those in Cluster 0. A defining characteristic is that every individual in this cluster has children, and a substantial portion are married, together, or divorced. Interestingly, the widowed population here is almost as high as the single population, making family dynamics in this group distinct from the other clusters. 

Education is a key differentiator for this group, with over 50% holding a Master's degree or higher, making them the most highly educated of all clusters. In terms of income, most members belong to the middle or second-highest income brackets, likely reflecting their advanced education and marital status, which contributes to higher household incomes. These factors also translate into their spending habits, as this cluster spends the most across all categories in the segmentation. 

When it comes to marketing campaigns, Campaign 4 was the most successful, with 40.91% acceptance, followed by Campaign 3, with a 29.29% acceptance rate.

Next is Cluster 2 or the Green Cluster -![image](https://github.com/user-attachments/assets/b3d3897b-1ba4-44d8-8ef6-63478e643563)
Cluster 2 represents the working professional, city-living population. This segment is notably the youngest of all, and it stands out as the only one with a significant presence of millennials. The label "working professional" is appropriate because, despite the high number of married individuals (119 out of 327), only one person in the entire cluster has children. When combining the Single and Together/Dating populations, they total 122, which aligns with typical city-dwelling demographic trends. 

This group tends to fall into the highest or second-highest income brackets, and most have completed their education at the undergraduate level, further emphasizing their status as young professionals. Their spending habits reflect this as well, with Cluster 2 ranking second in per capita spending across the entire segmentation. 

In terms of marketing campaigns, while no campaign stood out as overwhelmingly successful, Campaign 5 had the highest acceptance rate at 38.12%, followed by Campaign 1 at 27.8%.

Here is the last cluster, Cluster 3, or the Purple Cluster -![image](https://github.com/user-attachments/assets/c645e407-aef7-446c-bca2-a7dfa9807839)
The best way to describe Cluster 3 is retirees. This cluster is the oldest cluster, with people born mostly in the late 1940s and 1950s, indicating people entering into the later stages of life. Not one person in the cluster reported having children which makes sense considering the late age, at this age either the children are more than likely young adults or have moved out of the household. Over 2/3 of this population is either married or together.

This population is almost entirely in the highest and second highest income brackets, and almost half of the population has the highest level of education at undergraduate. This population is the highest spenders in terms of per capita, which makes sense considering they are retired.

In terms of marketing campaigns, while no campaign stood out as overwhelmingly successful, Campaign 5 had the highest acceptance rate at 32.93%, followed by Campaign 1 at 29.88%.

This analysis highlights how distinct demographic segments respond to different marketing strategies. Clusters like 0 and 1, with their family-oriented and middle-income dynamics, show strong responses to targeted campaigns, while younger professionals in Cluster 2 and retirees in Cluster 3 display specific spending habits. These insights can inform more tailored marketing approaches, leading to more effective campaign designs

