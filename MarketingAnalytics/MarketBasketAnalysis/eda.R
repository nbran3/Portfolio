library(tidyverse)
library(ggplot2)
library(lubridate)



df <- read.csv("online_retail.csv")

df$InvoiceDatetime <- as.POSIXct(df$InvoiceDate, format = "%m/%d/%Y %H:%M")

PopularItems <- df %>%
  group_by(StockCode) %>%
  summarize(Count = n()) %>%
  arrange(desc(Count)) %>%
  slice(1:10) %>%
  ggplot(aes(x = reorder(StockCode, Count), y = Count, fill = StockCode)) +
  geom_bar(stat= 'identity') +
  coord_flip()+
  ggtitle('Most Popular Items') +
  theme(legend.position = 'none')
  
PopularItems

ItemsSoldByDay <- df %>%
  mutate(Date = as.Date(InvoiceDatetime)) %>%
  group_by(Date) %>%
  summarise(Count = n()) %>%
  mutate(Day = wday(Date, label = TRUE)) %>% 
  ggplot(aes(x = Date, y = Count, fill = Day)) +
  geom_bar(stat = "identity") +
  ggtitle("Items sold per day")
  
ItemsSoldByDay

HourlySales <- df %>%
  mutate(Hour = as.factor(hour(InvoiceDatetime))) %>%
  group_by(Hour) %>%
  summarize(Count = n())
  
HourlyTransactions <- df %>%
  mutate(Hour = as.factor(hour(InvoiceDatetime))) %>%
  group_by(Hour,InvoiceNo) %>%
  summarise(n_distinct(InvoiceNo)) %>% 
  summarize(Count = n())
  
  
ItemsPerUniqueTrans <- data.frame(HourlySales, HourlyTransactions[2], HourlySales[2] / HourlyTransactions[2])
colnames(ItemsPerUniqueTrans) <- c("Hour", "Line", "Unique", "Items.Trans")

HourlySalesViz <-
  ggplot(ItemsPerUniqueTrans, aes(x=Hour, y=Items.Trans, fill=Hour)) +
  geom_bar(stat='identity') +
  ggtitle("Total items per transaction by hour") +
  theme(legend.position = "none") +
  geom_text(aes(label=round(Items.Trans, 1)), vjust=2)

HourlySalesViz
  
  
  
  
  
  
  
  
  
  
  