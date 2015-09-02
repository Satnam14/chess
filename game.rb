require_relative 'board'
require 'io/console'
require 'byebug'
require 'colorize'
require_relative 'cursor'
require_relative 'piece'
require_relative 'sliding_piece'
require_relative 'stepping_piece'
require_relative 'bishop'
require_relative 'knight'
require_relative 'king'
require_relative 'queen'
require_relative 'pawn'
require_relative 'rook'
require_relative 'human_player'

class Game

  attr_accessor :board, :turn, :players, :cursor, :error_messages

  def initialize
    @turn = :w
    @cursor = Cursor.new
    @board = Board.new(@cursor)
    @error_messages = []
  end

  def game_type
    puts "Welcome to Chess"
    puts "What type of game do you want to play?"
    puts "Enter 1 for Player vs. Player"
    puts "Enter 2 for Player vs. CPU"
    puts "Enter 3 for CPU vs. CPU"
    answer = gets.chomp.to_i
    if [1, 2, 3].include?(answer)
      if answer == 1
        @player1 = HumanPlayer.new
        @player2 = HumanPlayer.new
      elsif answer == 2
        @player1 = HumanPlayer.new
        @player2 = ComputerPlayer.new
      else
        @player1 = ComputerPlayer.new
        @player2 = ComputerPlayer.new
      end
    else
      puts "Invalid Input"
      game_type
    end
  end

  def play
    until board.checkmate?(turn) do
      while board.frozen_cursor.nil? || board.attacked_pos.nil? do
        move_selection
      end

      if board.moves_into_check?(turn)
        error_messages << "This leaves you in check, please make another move"
        board.frozen_cursor = nil
        board.attacked_pos = nil
        next
      else
        board.make_move
        switch_turn
      end

    end
    display_winner(turn)
  end

  def display_winner(turn)
    puts "Game Over"
    turn == :w ? "White Wins" : "Black Wins"
  end

  def display_error_messages
    error_messages.each do |message|
      puts message
    end
    @error_messages = []
  end

  def display_dev_info
    puts "Cursor position is cursor class: #{@cursor.pos}"
    puts "Frozen cursor = #{board.frozen_cursor}"
    puts "Attacked pos = #{board.attacked_pos}"
    if board.frozen_cursor
      p "Possible moves of frozen piece: #{board[board.frozen_cursor].moves}"
    end
    p "Possible moves of this position: #{board[@cursor.pos].moves}"
  end

  def move_selection
    # display_dev_info
    display_error_messages
    board.render(turn)
    puts "It's #{@turn == :w ? "White's" : "Black's"} turn" #change to names later
    input = $stdin.getch
    handle_input(input)
    system("clear")
  end

  def handle_input(input)
    if valid_input?(input)
      if input != " "
        @cursor.movement(input)
      else
        assign_positions if valid_move?
      end
    else
      error_messages << "Invalid input, please use W, A, S and D to navigate
      board. SPACE to select a position"
    end
  end

  def assign_positions
    if board.frozen_cursor.nil?
      board.frozen_cursor = cursor.pos
    else
      board.attacked_pos = cursor.pos
    end
  end

  def valid_move?
    if board.frozen_cursor.nil? && board[cursor.pos].color != turn
      # if user selects anything else instead of selecting one of his pieces
      error_messages << "Invalid move, please select one of your pieces"
      false
    elsif board.frozen_cursor && board[cursor.pos].color == turn
      # if user tries to capture one of his own pieces
      error_messages << "Invalid move, please move into a place"
      false
    elsif board.frozen_cursor && !board[board.frozen_cursor].moves.include?(cursor.pos)
      error_messages << "Selected piece cannot move into that position"
      false
    else
      true
    end
  end

  def valid_input?(input)
    return true if ["W", "A", "S", "D", " "].include?(input.upcase)
    false
  end

  def switch_turn
    @turn == :w ? @turn = :b : @turn = :w
  end

end

game = Game.new
game.play
