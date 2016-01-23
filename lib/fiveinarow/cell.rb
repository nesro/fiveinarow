class Cell
  attr_accessor :value
  attr_reader :row
  attr_reader :col

  EMPTY = 0
  PLAYER_A = 1
  PLAYER_B = 2

  def initialize(row, col, val)
    @row = row
    @col = col
    @value = val
  end

  def set(v)
    puts "changed to #{v}"
    @value = v
  end

  def e?
    @value == Cell::EMPTY
  end

  def a?
    @value == Cell::PLAYER_A
  end

  def b?
    @value == Cell::PLAYER_B
  end
end