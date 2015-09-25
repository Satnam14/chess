require 'colorize'
require_relative 'lib/board'
require_relative 'lib/human_player'
require_relative 'lib/computer_player'

class Game

  attr_accessor :board, :turn, :player1, :player2

  def initialize
    @turn = :w
    @board = Board.new
    game_type
  end

  def game_type
    puts "Welcome to Chess"
    puts "What type of game do you want to play?"
    puts "Enter 1 for Player vs. Player"
    puts "Enter 2 for Player vs. CPU (beta)"
    puts "Enter 3 for CPU vs. CPU (beta)"
    answer = gets.chomp.to_i
    if [1, 2, 3].include?(answer)
      if answer == 1
        @player1 = HumanPlayer.new
        @player2 = HumanPlayer.new
      elsif answer == 2
        @player1 = HumanPlayer.new
        @player2 = ComputerPlayer.new(:b)
      else
        @player1 = ComputerPlayer.new(:w)
        @player2 = ComputerPlayer.new(:b)
      end
    else
      puts "Invalid Input"
      game_type
    end
    @player1.board = @board
    @player2.board = @board
    play
  end

  def get_player(turn)
    player = turn == :w ? @player1 : @player2
    return player
  end

  def play
    until board.checkmate?(turn) do
      player = get_player(turn)
      player.select_move(turn)
      board.make_move
      switch_turn
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
