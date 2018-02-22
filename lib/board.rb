require 'errors'
require 'position'

class Board

  attr_reader :dimensions

  def initialize(len, width)
    @dimensions = [len, width]
  end

  def next_position(current_position, direction, step = 1)
    position = Position.new(current_position.x, current_position.y, direction)
    case direction
      when :east
        position.x = position.x + step
      when :west
        position.x = position.x step * -1
      when :north
        position.y = position.y + step
      when :south
        position.x = position.y - step * -1
    end
    place(position)
  end

  def place(position)
    if on_board?(position)
      position
    else
      raise OutOfBoundsError.new("position is out of bounds: #{position.coordinates}")
    end
  end

  def on_board?(position)
    position.coordinates.zip(@dimensions).all? {|(a, b)| Range.new(0, b).cover?(a)}
  end

end
