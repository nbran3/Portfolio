library(ggplot2)
library(psych)
library(GGally)
data <- read.csv('c:\\Users\\nbwan\\Downloads\\fredgraph.csv')


View(data)

psych::describe(data)

hist(data$UNEMPLOYMENT, main = 'Histogram of Unemployment from 1960-2022', xlab= 'Unemployment' ,col = 'blue')

hist(data$CPI.US, main = 'Histogram of CPI from 1960-2022', xlab = 'CPI', col = 'red')

hist(data$FEDFUNDS, main = 'Histogram of Federal Funds Rate from 1960-2022', xlab = 'Federal Fund Rate', col = 'green')


datagraphs <- data[,-1]
ggpairs(datagraphs)


correlation_matrix <- cor(datagraphs)
print(correlation_matrix)

model1 <- lm(data$CPI.US ~ data$FEDFUNDS, data = data)
summary(model1)


residuals1 <- resid(model1)

plot(fitted(model1), residuals1, xlab = "Fitted Values", ylab = "Residuals", main = "Residual Plot")

shapiro.test(residuals1)

qqnorm(residuals1)
qqline(residuals1)

model2 <- lm(data$CPI.US ~ data$FEDFUNDS + data$UNEMPLOYMENT, data = data)
summary(model2)


residuals2 <- resid(model2)

plot(fitted(model2), residuals2, xlab = "Fitted Values", ylab = "Residuals", main = "Residual Plot")

shapiro.test(residuals2)

qqnorm(residuals2)
qqline(residuals2)
