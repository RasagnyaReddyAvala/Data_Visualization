#Animated boxplot for Number of installs for free and paid apps

testB<-ggplot(google, aes(x='', y=google$Installs, fill =google$Type)) + 
  geom_boxplot(col="red", alpha=0.5, na.rm = TRUE , notch = TRUE) + 
  scale_y_continuous(name = waiver(), trans = "log10") +
  labs(title="Free vs Paid Apps Downloads", x="Free                     Paid", y="Installs in log10") + 
  guides(fill = guide_legend(title = "Type")) +
  theme(plot.title = element_text(size=16, face = "bold", color = "blue") ,axis.ticks.x = element_blank(), axis.title = element_text(size = 12, face = "bold")) +
  transition_states(states = google$Type, transition_length = 20, state_length = 20) +
  enter_appear(early = TRUE) + ease_aes('circular-in-out') + exit_shrink(fade = FALSE)

testB.gif <- animate(testB, nframes = 50, width=600, height=600)

testB.gif

