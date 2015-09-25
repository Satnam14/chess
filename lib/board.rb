require 'colorize'
require_relative 'pieces'
require_relative 'cursor'

class Board

  attr_accessor :cursor, :grid, :pos, :freeze, :frozen_cursor, :attacked_pos

  def initialize
    @grid = Array.new(8) { Array.new(8) { EmptySquare.new } }
    @freeze = false
    @frozen_cursor = nil
    @attacked_pos = nil
    populate_board
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row,col = pos
    @grid[row][col] = value
  end

  def populate_board
    royalty(0, :b)
    eight_pawns(1, :b)
    eight_pawns(6, :w)
    royalty(7, :w)
  end

  def royalty(row, color)
    pieces_array = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

    grid[row].each_with_index do |cell, cell_idx|
      pos = [row, cell_idx]
      piece_class = pieces_array[cell_idx]
      self[pos] = piece_class.new(color, pos, self)
    end
  end

  def eight_pawns(row, color)
    grid[row].each_with_index do |cell, cell_idx|
      pos = [row, cell_idx]
      self[pos] = Pawn.new(color, pos, self)
    end
  end

  def on_board?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end

  def occupied?(pos)
    self[pos].piece?
  end

  def valid_attack?(current_pos, attack_pos)
    occupied?(attack_pos) && self[attack_pos].color != self[current_pos].color
  end

  # def checkmate?
  #   false
  # end

  def dup #try with a flatten
    dup = Board.new
    dup.frozen_cursor = frozen_cursor
    dup.attacked_pos = attacked_pos
    (0..7).each do |row|
      (0..7).each do |piece|
        if self[[row, piece]].empty?
        dup.grid[row][piece] = self[[row, piece]].class.new
        else
          dup.grid[row][piece] = self[[row, piece]].class.new( self[[row, piece]].color, [row, piece], dup)
        end
      end
    end
    dup
  end

  def checkmate?(color)
    return false unless in_check?(color)

    grid.flatten.select { |p| p.color == color }.all? do |piece|
      piece.moves.all? do |move|
        duplicate_board = self.dup
        duplicate_board.frozen_cursor = piece.pos
        duplicate_board.attacked_pos = move
        duplicate_board.make_move
        duplicate_board.in_check?(color)
      end
    end
  end

  def in_check?(color) # color under attack
    #king can be taken on next move
    attacking_color = color == :b ? :w : :b
    king = find_king(color)
    grid.flatten.any? do |piece|
      piece.piece? && piece.color == attacking_color && piece.moves.include?(king.pos)
    end
  end

  def find_king(color)
    grid.flatten.find do |piece|
      piece.class == King && piece.color == color
    end
  end

  def moves_into_check?(color)
    duplicate_board = self.dup
    duplicate_board.make_move
    duplicate_board.in_check?(color)
  end


  def make_move
    if self[frozen_cursor].moves.include?(attacked_pos)
      if self[attacked_pos].empty?
        self[attacked_pos] = self[frozen_cursor]
        self[attacked_pos].pos = attacked_pos
        self[frozen_cursor] = EmptySquare.new
      else
        self[attacked_pos] = self[frozen_cursor]
        self[attacked_pos].pos = attacked_pos
        self[frozen_cursor] = EmptySquare.new
        #palce holder for storing the captured pieces
      end
    #else
      # change this to exceptions later
    end
    @frozen_cursor = nil
    @attacked_pos = nil
  end


  def render(color, cursor)
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |cell, col_idx|
        pos = [row_idx, col_idx]
        if pos == cursor.pos
          print cell.to_s.colorize(:background => :red)
        elsif frozen_cursor && self[frozen_cursor].moves.include?(pos) && self[frozen_cursor].color == color
          print cell.to_s.colorize(:background => :light_blue)
        elsif frozen_cursor.nil? && self[cursor.pos].moves.include?(pos) #&& self[frozen_cursor].color == color
          print cell.to_s.colorize(:background => :light_blue)
        else
          display_square(pos)
        end
      end
      puts
    end
  end

  def display_square(pos)
    row_idx, col_idx = pos
    if (row_idx + col_idx).even?
      background = :light_black
    else
      background = :light_yellow
    end
    print self[pos].to_s.colorize(background: background)
  end
end
