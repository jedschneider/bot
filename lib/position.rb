class Position
  attr_accessor :direction, :x, :y
  # TODO: switch arguments order x, y, direction to match rest of api
  def initialize(direction, x, y)
    @direction, @x, @y = [direction, x, y]
  end

  def coordinates
    [x, y]
  end
end
