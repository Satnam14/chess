class Cursor

  attr_accessor :pos

  def initialize
    @pos = [0, 0]
  end

  def movement(input)
    if input == "w"
      cursor_up
    elsif input == "a"
      cursor_left
    elsif input == "s"
      cursor_down
    elsif input == "d"
      cursor_right
    elsif input == " "
      select
    else
      raise "Cursor got a invalid input"
    end
  end

  def cursor_up
    if @pos.first > 0
      new_pos = [@pos.first - 1, @pos.last]
      @pos = new_pos
    end
  end

  def cursor_down
    if @pos.first < 7
      new_pos = [@pos.first + 1, @pos.last]
      @pos = new_pos
    end
  end

  def cursor_right
    if @pos.last < 7
      new_pos = [@pos.first, @pos.last + 1]
      @pos = new_pos
    end
  end

  def cursor_left
    if @pos.last > 0
      new_pos = [@pos.first, @pos.last - 1]
      @pos = new_pos
    end
  end

  def select
    puts "Select method got executed"

  end
end
