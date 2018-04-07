setwd("~/Documents/R/newFolder")
library(arules)
all.books.df <- read.csv("CharlesBookClub.csv")

# create a binary incidence matrix
count.books.df <- all.books.df[, 8:18]
incid.books.df <- ifelse(count.books.df > 0, 1, 0)
incid.books.mat <- as.matrix(incid.books.df[, -1])

#convert the binary incidence matrix into a transactions database
books.trans <- as(incid.books.mat, "transactions")
arules::inspect(books.trans)

#plot data 
itemFrequencyPlot(books.trans)

#run apriori function
rules <- apriori(books.trans, parameter = list(supp = 200/4000, conf = 0.5, target = "rules"))

#inspect rules
arules::inspect(sort(rules, by="lift"))
