class Bot

  DIRECTIONS = [:north, :east, :south, :west, :north]

  attr_accessor :logger, :current_position

  def initialize(board, logger = Logger.new('bot.log'))
    @board  = board
    @logger = logger
    yield self if block_given?
  end

  def place(x, y, direction)
    position = Position.new(x, y, direction)
    begin
      @current_position = @board.place(position)
      logger.info("place: #{current_position.to_s}")
    rescue OutOfBoundsError => e
      logger.warn("place: Place command failed: #{e}")
    end
  end

  def move
    with_current_position(:move) do
      @current_position = @board.next_position(current_position, current_position.direction)
    end
  end

  def left
    with_current_position(:left) do
      directions                  = DIRECTIONS.reverse
      current_position.direction = directions[1 + directions.index(current_position.direction)]
    end
  end

  def right
    with_current_position(:right) do
      current_position.direction = DIRECTIONS[1 + DIRECTIONS.index(current_position.direction)]
    end
  end

  def report
    with_current_position(:report) do
      puts current_position.to_s
    end
  end

  private

  def with_current_position(tag, &block)
    message = "#{tag}: "
    if current_position
      block.call
      logger.info(message + current_position.to_s)
    else
      message + 'No Place Command yet given'
      logger.warn(message + 'No Place Command yet given')
    end
  end
end
