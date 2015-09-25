# Minimax
# 1. Get all possible moves for Ozil.
# 2. Each possible move will have a score assocaited with it.
# 3. Try all the moves (use deep_dup) - moves.each do |move|
#    3.1. If the move captures a piece, increase its score according to the
#         status of the captured piece.
#    3.2. Get all the possible moves the user can make after move.
#         Try all the moves (use deep_dup) - moves.each do |move|
#         3.2.1. Decrease score if user can capture Ozil's pieces.
#         3.2.2. Recurse 1, exactly 5 times.
# 4. Make the move with highest score.
require 'byebug'

class Move
  attr_accessor :from_pos, :to_pos, :score, :board, :children_moves

  def initialize(from, to, board)
    @from_pos = from
    @to_pos = to
    @score = 0
    @board = board.dup
    @children_moves = []
  end
end

module Ozil
  CAPTURE_SCORES = {
    EmptySquare => 0,
    Pawn => 1,
    Knight => 3,
    Bishop => 3,
    Rook => 5,
    Queen => 9,
    King => 1000
  }


  def all_pieces(player, board)
    pieces = []
    board.grid.flatten.each do |piece|
      pieces << piece if piece.color == player
    end

    pieces
  end

  def all_possible_moves(player, board)
    possible_moves = [];
    all_pieces(player, board).each do |piece|
      piece.moves.each do |move|
        possible_moves << Move.new(piece.pos, move, board)
      end
    end

    possible_moves
  end

  def highest_score(moves)
    highest_score = 0
    best_move = nil
    moves.each do |move|
      if move.score >= highest_score
        best_move = move
        highest_score = move.score
      end
    end

    best_move
  end

  def weigh_move(move, player)
    if player == color
      move.score += CAPTURE_SCORES[move.board[move.to_pos].class]
    else
      move.score -= CAPTURE_SCORES[move.board[move.to_pos].class]
    end
    move.board.frozen_cursor = move.from_pos
    move.board.attacked_pos = move.to_pos
    move.board.make_move
    move
  end

  def other_player(player)
    if player == :b
      return :w
    else
      return :b
    end
  end

  def ozil(moves, times, player)
    return if times == 0
    moves.each do |move|
      move = weigh_move(move, player)
      # puts move.score if move.score != 0
      children_moves = all_possible_moves(other_player(player), move.board)
      move.children_moves = ozil(children_moves, times - 1, other_player(player))
    end
    moves
  end
end
