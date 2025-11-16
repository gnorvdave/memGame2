SwiftUI Memory Game for Wk 13 There are 3 source files in this repository, that comply with the MVVM architecture :-

View - ContentView ViewModel - FlowerMemoryGame Model - MemoryGame

Description.
A progress bar is added to the memgame developed for Lab3. 
Flip count and reset functions have been kept

So in ContentView there is an onTapGesture, which calls viewModel.choose(card), which calls choose in the model, 
at the bottom of which is included a call to updateProgressdirectly after the flipCount is incremented.

Progress is declared and initialized to zero as a double at the top of the file.

Inside the updateProgress function, whilst progress is less than 100% 1/12th is added to the running total.
This progress is passed up through the viewModel and called in the ContentView.

Please watch the video to see the Progress bar in action whilst the game is played - below is a link to the video

Wk13 Video Link
https://drive.google.com/file/d/1MsWGymh9rrn-UG5HvPWyElEQLy3uq3vL/view?usp=sharing
