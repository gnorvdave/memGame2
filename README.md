SwiftUI Memory Game for Wk 13 There are 3 source files in this repository, that comply with the MVVM architecture :-

1) View -       ContentView 
2) ViewModel   FlowerMemoryGame
3) Model -     MemoryGame

Description.
A progress bar is added to the memgame written for Lab3. 
Flip count and reset functions have been retained

In ContentView there is an onTapGesture, which calls viewModel.choose(card), which calls choose in the model, 
near the top of which is an increment to the flipCount counter and further down, when first.content == second.content is true, a call to incrementProgressForMatch adds 1/12 to the progress bar & count.

Progress is declared and initialized to zero as a double at the top of the Model file.

Inside the incrementProgressForMatch function, whilst progress is less than 100% 1/12th is added to the running total.
This progress is passed up through the viewModel - var progress: Double {model.progress} and called in the ContentView
with - let percent = Int(viewModel.progress.rounded()).

Please watch the video to see the Progress bar in action whilst the game is played - below is a link to the video

Wk13 Video Link
https://drive.google.com/file/d/1MsWGymh9rrn-UG5HvPWyElEQLy3uq3vL/view?usp=sharing
