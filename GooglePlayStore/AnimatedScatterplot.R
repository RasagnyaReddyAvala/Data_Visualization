testS<-ggplot(Top10, aes(Top10$Rating, Top10$Reviews, col=Top10$Category, size=Top10$Installs)) + 
  geom_point(alpha=0.4, na.rm = TRUE) + theme_minimal() +
  labs(title="Ratings vs Reviews", x="Rating", y="Number of Reviews") + guides(size = guide_legend(title = "Top 10 Installs"), col= guide_legend(title = "Top 10 Categories")) +
  theme(plot.title = element_text(size=16, face = "bold", color = "blue"), axis.title = element_text(size = 12, face = "bold")) + 
 #color_palette <- palette = c(topo.colors(10, alpha=1)) + 
  #scale_color_manual(values = c(topo.colors(10, alpha=1), aesthetics = "colour")) +
  transition_states(states = Top10$Category, transition_length = 2, state_length = 200) + 
  enter_grow(fade = FALSE) + ease_aes('bounce-in-out')

testS.gif<-animate(testS, nframes = 300, width=600, height=600)

testS.gif
