SwiftUI Memory Game for Wk 13 There are 3 source files in this repository, that comply with the MVVM architecture :-

View - ContentView ViewModel - FlowerMemoryGame Model - MemoryGame

Description.
A progress bar is added to the memgame developed for Lab3. 
I’m still struggling with the matching logic for the memory game, so this version doesn’t have it – instead the Progress bar increments when any tile is tapped.

So in ContentView there is an onTapGesture, which calls viewModel.choose(card), which calls choose in the model, 
at the bottom of which is included a call to updateProgressdirectly after the flipCount is incremented.

Progress is declared and initialized to zero as a double at the top of the file.

Inside the updateProgress function, whilst progress is less than 100% 1/12th is added to the running total.
This progress is passed up through the viewModel and called in the ContentView.

Please watch the video to see the Progress bar in action - below is a link to the video

Link to the video
https://drive.google.com/file/d/1Gwnvpf70OQSalYyQhL0XvamsrbH2kwMj/view?usp=sharing
