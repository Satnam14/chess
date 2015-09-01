class Knight < Piece
  include Stepable
  KNIGHT_MOVES = [
    [-2, -1],
    [-2,  1],
    [-1, -2],
    [-1,  2],
    [ 1, -2],
    [ 1,  2],
    [ 2, -1],
    [ 2,  1]
  ]

  def stepping_diff
    KNIGHT_MOVES
  end

  def to_s
    color == :b ? " \u265E ".colorize(:black) : " \u265E ".colorize(:white)
  end
end
