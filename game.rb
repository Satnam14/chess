require_relative 'board'
require 'io/console'
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

  attr_accessor :board, :turn, :players

  def initialize
    @turn = :w
    @cursor = Cursor.new
    @board = Board.new(@cursor)
  end

  def play
    puts "Welcome to Chess"
    until board.checkmate? do
      while board.frozen_cursor.nil? || board.attacked_pos.nil? do
        move_selection
      end
      # validate_move(restrict a player to move the other players piece)
      # if board.frozen_cursor
      # moves_into_check?
      board.make_move
      # if board.moves_to_check?
      #   raise "this leaves you in check, please play another move"
      # else
      #   board.make_move
      # end
      switch_turn
    end
  end

  def move_selection
    puts "Cursor position is cursor class: #{@cursor.pos}"
    puts "Frozen cursor = #{board.frozen_cursor}"
    puts "Attacked pos = #{board.attacked_pos}"
    board.render(turn)
    puts "It's #{@turn == :w ? "White's" : "Black's"} turn" #change to names later
    input = $stdin.getch
    if input == " "

    @cursor.movement(input)
    system("clear")
  end

  def valid_move?(pos, turn)
    if board.frozen_cursor.nil? && board[pos].color != turn
      # if user selects an empty square instead of selecting one of his pieces
      raise "Invalid move, please select one of your pieces"
      false
    elsif board.frozen_cursor != nil && board[pos].color == turn
      # if user tries to capture one of his own pieces
      raise "Invalid move, please move into a place"
      false
    else
      true
    end
  end

  def switch_turn
    @turn == :w ? @turn = :b : @turn = :w
  end

end

game = Game.new
game.play
