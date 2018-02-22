class Position
  attr_accessor :direction, :x, :y

  def initialize(x, y, direction)
    @x, @y, @direction = [x, y, direction]
  end

  def coordinates
    [x, y]
  end

  def to_s
    "#{coordinates.inspect} facing: #{direction}"
  end
end
