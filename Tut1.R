path <- "D:/ISY 351/Tut1"
setwd(path)
#Load Datasets
train <- read.csv("Train_UWu5bXk.csv")
test <- read.csv("Test_u94Q5KV.csv")
table(is.na(train))
colSums(is.na(train))
summary(train)
ggplot(train, aes(x= Item_Weight, y = Item_MRP)) + geom_point(size = 0.5, color="red") + xlab("Item_Weight") + ylab("Item Price") + ggtitle("Item W vs Item Price")
test$Item_Outlet_Sales <-  1
combi <- rbind(train, test)
mw <- median(combi$Item_Weight, na.rm = TRUE)
mw
combi$Item_Weight[is.na(combi$Item_Weight)]<-mw

combi$Item_Visibility <- ifelse(combi$Item_Visibility == 0, median(combi$Item_Visibility), combi$Item_Visibility)

levels(combi$Outlet_Size)[1] <- "Other"

library(plyr)
combi$Item_Fat_Content <- revalue(combi$Item_Fat_Content, c("LF" = "Low Fat", "reg" = "Regular", "low fat" = "Low Fat"))
library(dplyr)
a <- combi%>%group_by(Outlet_Identifier)%>%tally()
a<-tally(group_by(combi,Outlet_Identifier))
names(a)[2] <- "Outlet_Count"
a
combi <- full_join(a, combi, by = "Outlet_Identifier")
