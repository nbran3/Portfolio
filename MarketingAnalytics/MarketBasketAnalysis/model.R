library(arules)
library(arulesViz)
library(RColorBrewer)
library(dplyr)

data <- read.csv("online_retail.csv")

letter_mapping <- c(
  A = "101", B = "102", C = "103", D = "104", E = "105",
  F = "106", G = "107", H = "108", I = "109", J = "110",
  K = "111", L = "112", M = "113", N = "114", O = "115",
  P = "116", Q = "117", R = "118", S = "119", T = "120",
  U = "121", V = "122", W = "123", X = "124", Y = "125", Z = "126"
)

replace_letters <- function(code) {
  for (letter in names(letter_mapping)) {
    code <- gsub(letter, letter_mapping[letter], code)
  }
  return(code)
}

data$StockCode <- sapply(data$StockCode, replace_letters)

write.csv(data, "transformed.csv", row.names = FALSE)

tr <- read.csv("transformed.csv")

transactions <- tr %>%
  select(InvoiceNo, StockCode)

write.csv(data, "transactions.csv", row.names = FALSE)

transactions <- read.transactions("transactions.csv", format = "single", sep = ",", cols = c("InvoiceNo", "StockCode"), header = TRUE)


rules <- apriori(transactions, parameter = list(supp = 0.002, conf = 0.7))

summary(rules)

inspect(rules[1:10])

plot(rules[1:10], measure="confidence", method="graph", control=list(type="items"), shading = "lift")

plot(rules, control=list(jitter=2, col = rev(brewer.pal(9, "Greens")[c(3,7,8,9)])),shading = "lift")


rules.sub <- subset(rules, subset = lift > 1.20)
plot(rules.sub, method = "graph", engine = "html")
