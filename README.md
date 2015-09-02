# Chess

How to download and run

. Install Ruby. If you already have installed Ruby then skip to step 2
. Download this repository (Click "Download as Zip button on the right")
. Extract the downloaded zip into the director of your choice
. Open a terminal (Mac and Linux) or a Command-prompt (Windows)
. CD into the directory where you extracted the zip file
. Run the game using the command "Ruby game.rb"

How to Play
. Inside the game, you can move the cursor using the arrow keys
. Select the piece you want to move using the Enter key
. Select the place you want to move into using the Enter key
. [COLOR] squares indicate all the positions the selected piece can move into
. Instruction on how to play Chess - [wikipedia]

To Do -

[ ] Make a board class that has a grid to hold pieces
[ ] Make classes for Steppable and Slideable pieces
[ ] Rook, Bishop, Queen inherit from Slideable
[ ] King, Knight and Pawn inherit from Steppable
[ ] Make #possible_moves methods for Steppable and Slideable
[ ] Copy AA stuff 
[x] Invalid move if the user tries to move into a position that is not in piece.moves
[ ] Add a key for quit game
[ ] Allow user to move the cursor using the allow keys and select using Enter
[ ] Refactor so that all lines are < 80 chars
[ ] Allow user to re-select the piece he wants to move
[ ] Improve folder structure
[ ] Implement Human Player class
[ ] Implement Computer Player class
