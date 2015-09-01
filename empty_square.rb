class EmptySquare
  def piece?
    false
  end

  def color
    :none
  end

  def moves
    []
  end

  def empty?
    true
  end

  def to_s
    "   "
  end

end
