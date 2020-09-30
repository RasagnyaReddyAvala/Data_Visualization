#free vs paid interactive 2
updated_Type <- subset(google,Type=="Free"|Type=="Paid")
library(ggplot2)
library(plotly)

z<-ggplot(data = updated_Type) +
  aes(x = Category, fill = Type) +
  geom_bar() +
  labs(title = "Free vs Paid by Category",
       y = "Count") +
  theme_classic() +
  coord_flip()

ggplotly(z)