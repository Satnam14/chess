# Chess

## Introduction

Each player begins the game with 16 pieces: one king, one queen, two rooks, two knights, two bishops, and eight pawns. Each of the six piece types moves differently. The most powerful piece is the queen and the least powerful piece is the pawn. The objective is to 'checkmate' the opponent's king by placing it under an inescapable threat of capture. To this end, a player's pieces are used to attack and capture the opponent's pieces, while supporting their own. In addition to checkmate, the game can be won by voluntary resignation by the opponent, which typically occurs when too much material is lost, or if checkmate appears unavoidable. A game may also result in a draw in several ways.

## How to download and run

1. Install Ruby. If you already have installed Ruby then skip to step 2
2. Download this repository (Click "Download as Zip button on the right")
3. Extract the downloaded zip into the director of your choice
4. Open a terminal (Mac and Linux) or a Command-prompt (Windows)
5. CD into the directory where you extracted the zip file
6. Run the game using the command "Ruby game.rb"

## How to Play

1. Inside the game, you can move the cursor using the W, A, S and D keys
2. Select the piece you want to move using the SPACE key
3. Select the place you want to move into using the Enter key
4. [COLOR] squares indicate all the positions the selected piece can move into
5. Hold down CTRL+C to quit at any time
5. Wikipedia - [Wikipedia](https://en.wikipedia.org/wiki/Chess#Rules)

## To Do

- [x] Make a board class that has a grid to hold pieces
- [x] Make a cursor class that has methods for moving and selecting from positions
- [x] Make classes for Steppable and Slideable pieces
- [x] Rook, Bishop, Queen inherit from Slideable
- [x] King, Knight and Pawn inherit from Steppable
- [x] Make #possible_moves methods for Steppable and Slideable
- [x] Make a method Board#in_check(color) that returns true if color is under check
- [x] Make a method Board#checkmate(color) that returns true if the color is under checkmate
- [x] Make a game class that controls the board and interacts with the user for input
- [x] Invalid move if the user tries to move into a position that is not in piece.moves
- [ ] Add a key for quit game
- [ ] Allow user to move the cursor using the allow keys and select using Enter
- [ ] Refactor so that all lines are < 80 chars
- [ ] Allow user to re-select the piece he wants to move
- [ ] Improve folder structure
- [ ] Implement Human Player class
- [ ] Implement Computer Player class
