require 'byebug'
require_relative 'board'
require_relative 'ozil'

class ComputerPlayer
  include Ozil
  attr_accessor :name, :board, :color

  def initialize(color)
    @name = "AI"
    @color = color
  end

  def select_move(turn)
    a = Time.now
    possible_moves = all_possible_moves(turn, board)
    b = Time.now
    moves_tree = ozil(possible_moves, 3, turn)
    c = Time.now
    # visualize_tree(moves_tree)
    best_move = highest_score(moves_tree)
    d = Time.now
    execution_times(a, b, c, d)
    board.frozen_cursor = best_move.from_pos
    board.attacked_pos = best_move.to_pos
  end

end
