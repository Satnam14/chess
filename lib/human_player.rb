require 'io/console'
require_relative 'cursor'
require_relative 'board'

class HumanPlayer
  attr_accessor :name, :cursor, :error_messages, :board, :turn

  def initialize
    # @name = name
    @cursor = Cursor.new
    @error_messages = []
  end

  def select_move(turn)
    @turn = turn
    while board.frozen_cursor.nil? || board.attacked_pos.nil? do
      move_selection
    end

    if board.moves_into_check?(turn)
      error_messages << "This leaves you in check, please make another move"
      board.frozen_cursor = nil
      board.attacked_pos = nil
      select_move(turn)
    end
  end

  def display_error_messages
    error_messages.each do |message|
      puts message
    end
    @error_messages = []
  end

  def move_selection
    # display_dev_info
    display_error_messages
    board.render(turn, cursor)
    puts "It's #{turn == :w ? "White's" : "Black's"} turn"
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


  def display_dev_info
    puts "Cursor position is cursor class: #{@cursor.pos}"
    puts "Frozen cursor = #{board.frozen_cursor}"
    puts "Attacked pos = #{board.attacked_pos}"
    if board.frozen_cursor
      p "Possible moves of frozen piece: #{board[board.frozen_cursor].moves}"
    end
    p "Possible moves of this position: #{board[@cursor.pos].moves}"
  end

end
