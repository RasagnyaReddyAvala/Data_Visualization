

testH<-ggplot(Top3, aes(Top3$Year, fill=Top3$Category)) + geom_histogram(bins = 25) + 
  theme_classic() + labs(title="Growth of Top 3 Category Apps over Years", x="Year", y="Apps Count") + guides(fill = guide_legend(title = "Apps Category")) +
  theme(plot.title = element_text(size=16, face = "bold", color = "blue"), axis.title = element_text(size = 12, face = "bold")) +
transition_states(states = Top3$Year, transition_length = 20, state_length = 20) +
  enter_grow(fade=FALSE) + ease_aes('sine-in')
                                                                                                  
testH.gif <- animate(testH, nframes = 50, width=600, height=600)

testH.gif
