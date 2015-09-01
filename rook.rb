class Rook < Piece
include Slideable

  ROOK_DIRS = [
    [0 , 1],
    [1,  0],
    [0, -1],
    [-1, 0]
  ]

  def direction_diff
    ROOK_DIRS
  end

  def to_s
    color == :b ? " \u265C ".colorize(:black) : " \u265C ".colorize(:white)
  end
end
