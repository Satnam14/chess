require 'colorize'
require_relative 'lib/board'

class Game

  attr_accessor :board, :turn, :players, :cursor, :error_messages

  def initialize
    @turn = :w
    @cursor = Cursor.new
    @board = Board.new(@cursor)
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

  def get_player(turn)
    player = turn == :b ? @player1 : @player2
    return player
  end

  def play
    until board.checkmate?(turn) do
      player = get_player(turn)
      player.select_move(board)

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

  def switch_turn
    @turn == :w ? @turn = :b : @turn = :w
  end

end

game = Game.new
game.play
