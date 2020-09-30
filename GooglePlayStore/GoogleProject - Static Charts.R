library(ggplot2)
library(stats)
library(esquisse)
library(lubridate)
library(dplyr)
library(scales)
library(animation)
library(plotly)
library(gganimate)
library(RColorBrewer)
library(ggExtra)
google<-read.csv2(file = "googleplaystore.csv", fill=TRUE, header = TRUE, sep = ",", dec = ".")
google$Reviews<-as.numeric(google$Reviews)
#attach(google)
google$Last.Updated<-dmy(as.character(google$Last.Updated))
google$Size<-gsub("M", "", google$Size, ignore.case = TRUE)
google$Size<-as.numeric(google$Size)
google$Installs<-gsub("+", "", google$Installs, fixed = TRUE)
google$Installs<-gsub(",", "", google$Installs)
options(scipen = 999)
google$Installs<-as.numeric(google$Installs)
google$Price<-as.numeric(gsub("[$]", "", google$Price))
google$Year<- lubridate::year(google$Last.Updated)

#Dataframe based on # of installs
installCat<-aggregate(google$Installs, by=list(google$Category), FUN=sum)
names(installCat) <- c("Category", "Installs")
installCat<-installCat[order(-installCat$Installs),]
levels(installCat$Category) <- reorder(installCat$Category, installCat$Installs) #ordering based on installs

#Dataframe for Top 10 based on # of installs 
Top10Category<-filter(installCat, installCat$Installs > mean(installCat$Installs))
Top10<-filter(google, google$Category %in% as.vector(Top10Category$Category))

#DF for Top3 categories based on # of apps
Top3<-filter(google, google$Category %in% c("FAMILY", "GAME", "TOOLS"))

#Top categories based on # of apps vs # of installs

#Dataframe for categories based on downloads
ByInstall<-aggregate(google$Installs, by=list(google$Category), FUN=sum)
names(ByInstall) <- c("Category", "Frame")
#Top 10 categories
BITop10<-filter(ByInstall, ByInstall$Frame > mean(ByInstall$Frame))

#Second dataframe for categories based on apps count
ByApps<- as.data.frame(google %>% group_by(google$Category) %>% count())
names(ByApps) <- c("Category", "Frame")
#Top 10 categories
BATop10<-filter(ByApps, ByApps$Frame > 370) #mean is 328 which gives top 13 categories, want to compare only 10, hence taking 370 as the limit

CombinedTop10 <-BITop10
CombinedTop10$AppsCount<-BATop10$Frame
names(CombinedTop10)<-c("Category", "InstallCt", "AppCt")

#Static boxplot for category vs size
library(ggplot2)

ggplot(data = google) +
  aes(x = Category, y = Size) +
  geom_boxplot(fill = "#a6761d") +
  labs(title= "Category vs Size") + coord_flip() +
theme_classic()


#distribution of ratings - Average raing of application is around 4.19 which is high
ggplot(google, aes(google$Rating, y=..count..)) + 
  geom_density(na.rm=TRUE, color="brown", fill="lightblue") + 
  geom_vline(xintercept = mean(google$Rating, na.rm = TRUE), col = "brown") +
  labs(title="Distribution of Rating", x="Rating", y="Number of Apps") +
  theme(plot.title = element_text(size=16, face = "bold", color = "blue"), axis.title = element_text(size = 12, face = "bold"))



#size for free and paid
ggplot(google, aes(google$Rating, google$Size, col = google$Type)) + 
  geom_point(na.rm = TRUE, size =3, alpha = 0.2) +
  labs(title="Size vs Ratings for Free and Paid Apps", x="Rating", y="Size of Apps in MB") + 
  guides(col = guide_legend(title = "Type")) +
  theme(plot.title = element_text(size=16, face = "bold", color = "blue"), axis.title = element_text(size = 12, face = "bold")) +
  scale_fill_manual(values = c("#00BB4E", "#FF61CC")) 



#Marginal plot for to 10 categorories of Apps and Installs
combined<-ggplot(CombinedTop10, aes(x=CombinedTop10$InstallCt, y=CombinedTop10$AppCt, col=CombinedTop10$Category)) + 
  geom_point(size=5, shape = 15) + guides(col = guide_legend(title = "Apps Category")) +
  labs(title="Number of Apps in Top 10 Category and their Install count", x="Number of Installs", y="Number of Apps") + 
  theme(legend.position = "bottom") + guides(fill = guide_legend(title = "App Category")) +
  theme(plot.title = element_text(size=16, face = "bold", color = "blue") , axis.title = element_text(size = 12, face = "bold")) 

  ggMarginal(combined, type = "histogram", fill="lightblue")




