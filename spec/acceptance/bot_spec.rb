describe 'Bot acceptance tests' do
  include IOHelpers

  let(:log) {StringIO.new}
  let(:logger) {Logger.new(log)}
  let(:board) {Board.new(5, 5)}

  describe 'invalid placement at start' do

    it 'ignores front loaded bad placements' do
      bot = Bot.new(board, logger) do |b|
        b.place(0, 6, :east)
        b.place(6, 0, :east)
        b.place(0, 0, :north)
        b.move
      end

      expect(get_report(bot)).to eq("[0, 1] facing: north")
    end

    it 'ignores other commands' do
      bot = Bot.new(board, logger) do |b|
        b.place(0, 6, :east)
        b.place(6, 0, :east)
        b.move
        b.right
        b.report
        b.place(0, 0, :north)
        b.move
      end

      expect(get_report(bot)).to eq("[0, 1] facing: north")
    end
  end

  describe 'specifications given' do

    it 'passes Example A' do
      bot = Bot.new(board, logger) do |b|
        b.place(0,0,:north)
        b.move
      end

      expect(get_report(bot)).to eq("[0, 1] facing: north")
    end

    it 'passes Example B' do
      bot = Bot.new(board, logger) do |b|
        b.place(0,0,:north)
        b.left
      end

      expect(get_report(bot)).to eq("[0, 0] facing: west")
    end

    it 'passes Example C' do
      bot = Bot.new(board, logger) do |b|
        b.place(1,2,:east)
        b.move
        b.move
        b.left
        b.move
      end

      expect(get_report(bot)).to eq("[3, 3] facing: north")
    end
  end

  describe 'logging the history of the bot' do

    it 'can log warnings' do
      bot = Bot.new(board, logger) do |b|
        b.place(0, 6, :east)
        b.place(1,2,:east)
        b.move
      end

      logs = log.string.split(/\n/)
      expect(logs.select {|l| l[0] == "W"}.count).to eq(1)
    end

    it 'can log info' do
      bot = Bot.new(board, logger) do |b|
        b.place(0, 6, :east)
        b.place(1,2,:east)
        b.move
      end

      logs = log.string.split(/\n/)
      expect(logs.select {|l| l[0] == "I"}.count).to eq(2)
    end
  end

  describe 'without the builder pattern' do

    it 'acts like a regular object' do
      bot = Bot.new(board, logger)
      bot.place(1,2,:east)
      bot.move

      expect(get_report(bot)).to eq("[2, 2] facing: east")
    end
  end
end
