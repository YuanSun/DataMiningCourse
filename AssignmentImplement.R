#Set correct working directory
setwd("~/Documents/R/newFolder")
library(arules)
library(stringr)
# !!!!!replace "." with 0 in excel before import to R
all.purchase.df <- read.csv("CatalogCrossSell.csv")
options(max.print=999999)
# create a binary incidence matrix
count.purchase.df <- all.purchase.df[, 2:10]
incid.purchase.df <- ifelse(count.purchase.df > 0, 1, 0)
incid.purchase.mat <- as.matrix(incid.purchase.df[, -1])

#convert the binary incidence matrix into a transactions database
purchase.trans <- as(incid.purchase.mat, "transactions")
arules::inspect(purchase.trans)

#plot data 
itemFrequencyPlot(purchase.trans)

#run apriori function
rules <- apriori(purchase.trans, parameter = list(supp = 200/4000, conf = 0.5, target = "rules"))

#inspect rules
output <- arules::inspect(sort(rules, by="lift"))
