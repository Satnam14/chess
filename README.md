# Chess

## Introduction

![Screenshot](http://res.cloudinary.com/satnam14/image/upload/c_scale,w_505/v1441732990/chess_n9ddmt.jpg)

## How to download and run

1. Install Ruby. If you already have installed Ruby then skip to step 2
2. Download this repository (Click "Download as Zip button on the right")
3. Extract the downloaded zip into the directory/folder of your choice
4. Open a terminal
  - If you're on Mac, press CMD + SPACE and type terminal
  - If you're on Windows, press the Windows key and type cmd
5. CD into the directory where you extracted the zip file
  - See this if you're not sure what that means[Terminal Basic](http://mac.appstorm.net/how-to/utilities-how-to/how-to-use-terminal-the-basics/)
6. Run the game using the command "ruby game.rb"

## How to Play

1. Inside the game, you can move the cursor using the W, A, S and D keys
2. Select the piece you want to move using the SPACE key
3. Select the place you want to move into using the Enter key
4. Blue squares indicate all the positions the selected piece can move into
5. Hold down CTRL+C to quit at any time
5. Wikipedia - [Wikipedia](https://en.wikipedia.org/wiki/Chess#Rules)

# Classes and Object-Oriented Design

- Game
  - Starts the game with the desired set of players (E.g. Human vs. CPU, Human vs. Human)
  - Owns the chessboard and moves pieces after getting input from players
  - Ends the game upon checkmate
  - Displays the winner
- Board
  - Owns an 8x8 grid to represent a chess board
  - Initializes with 32 pieces in their default positions
  - Holds all pieces and their positions throughout the game
  - Checks if a particular move results in a check and then prohibits it
  - Uses colorize gem to render the state of the grid
  - Gets the position of the cursor from HumanPlayer and displays it in red
  - Uses #possible_moves method of each piece to determine the available moves of the selected piece
  - Displays the available moves in blue for the selected piece
- HumanPlayer
  - Owns the cursor and its position on the board
  - Gets the input from user for moving the cursor and making a move
  - Validates the user input
  - Validates that user moves only his/her own pieces
  - Validates if the user made a correct move with a particular piece
- ComputerPlayer
  - Includes the Ozil module
  - Submits the best possible move the Game asks for a move
  - Best possible move is calculated by Ozil
- Ozil (module)
  - Constructs a tree of all possible moves the CPU can make at a particular time
  - Tree is n layered deep (E.g. Layer 1 - CPU moves, Layer 2 - User moves, Layer 3 - CPU moves, so on)
  - Each possible move has a score associated with it
  - The score of a move depends on the status of the captured piece (if any)
  - #highest_score method searches the tree recursively and outputs the best possible move
- And one for each piece type (E.g. Pawn, Knight, Rook, Queen etc)
  - King and Knight include the module Steppable
  - Queen, Bishop, Rook include the module Slideable
  - Both Steppable and Slideable have method #possible_moves that return all the valid positions that a piece can move into

## Basics of Chess

Each player begins the game with 16 pieces: one king, one queen, two rooks, two knights, two bishops, and eight pawns. Each of the six piece types moves differently. The most powerful piece is the queen and the least powerful piece is the pawn. The objective is to 'checkmate' the opponent's king by placing it under an inescapable threat of capture. To this end, a player's pieces are used to attack and capture the opponent's pieces, while supporting their own. In addition to checkmate, the game can be won by voluntary resignation by the opponent, which typically occurs when too much material is lost, or if checkmate appears unavoidable. A game may also result in a draw in several ways.

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
- [x] Improve folder structure
- [ ] Implement Human Player class
- [ ] Implement Computer Player class that is powered by the minimax algorithm
