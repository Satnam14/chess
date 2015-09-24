class ComputerPlayer
  attr_accessor :name

  def initialize(name)
    @name = "AI"
  end

  def get_input
    input = $stdin.getch
  end

  
end
