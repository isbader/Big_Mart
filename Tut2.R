path <- "D:/ISY 351/Tut2"
setwd(path)
train <- read.csv("Train_UWu5bXk.csv")
test <- read.csv("Test_u94Q5KV.csv")
summary(train)
table(is.na(train))
colSums(is.na(train))
#install.packages("ggplot2")
#library(ggplot2)
ggplot(train, aes(x= Item_MRP, y = Item_Weight)) + geom_point(size = 1.5, color="red") + xlab("Item Price") + ylab("Item Weight") + ggtitle("Item Price vs Item Weight")
test$Item_Outlet_Sales <-  1
combi <- rbind(train, test)
mw <- median(combi$Item_Weight, na.rm = TRUE)
mw
combi$Item_Weight[is.na(combi$Item_Weight)] <- mw
combi$Item_Visibility <- ifelse(combi$Item_Visibility == 0, median(combi$Item_Visibility), combi$Item_Visibility)
levels(combi$Outlet_Size)[1] <- "Other"
library(plyr)
combi$Item_Fat_Content <- revalue(combi$Item_Fat_Content, c("LF" = "Low Fat", "reg" = "Regular", "low fat" =  "Low Fat"))

#Feature Eng.
library(dplyr)
a <- tally(group_by(combi, combi$Outlet_Identifier))
#b1 <- combi%>%group_by(Outlet_Identifier)%>%tally()
#b
#b1<-table(combi$Outlet_Identifier)
#b1

names(a)[2] <- "Outlet_Count"
names(a)[1] <- "Outlet_Identifier"
combi <- full_join(a, combi, by = "Outlet_Identifier")


