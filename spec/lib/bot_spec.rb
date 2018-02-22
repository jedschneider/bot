describe Bot do
  include IOHelpers

  let(:board) {Board.new(5, 5)}
  let(:logger) {double(:logger)}
  let(:bot) {Bot.new(board, logger)}

  describe '#place' do

    describe 'when placed on the board' do

      it 'places the bot on the board' do
        bot.place(0, 0, :east)
        expect(bot.current_position.coordinates).to eq([0, 0])
      end

      it 'faces the correct direction' do
        bot.place(0, 0, :east)
        expect(bot.current_position.direction).to eq(:east)
      end

    end

    describe 'when placed off the board' do

      it 'ignores the command and logs the action' do
        expect(logger).to receive(:info)
        bot.place(6, 0, :east)
      end

      it 'does not set the current_position' do
        expect(logger).to receive(:info)
        bot.place(6, 0, :east)
        expect(bot.current_position).to be nil
      end

    end
  end

  describe '#move' do

    it 'moves the bot one space forward' do
      bot.place(0, 0, :east)
      expect {bot.move}.to change {bot.current_position.x}.from(0).to(1)
    end

    describe 'without a place command' do

      it 'ignores the command and logs the action' do
        expect(logger).to receive(:info)
        expect {bot.move}.to_not change {bot.current_position}
      end
    end
  end

  describe '#left' do

    it 'solves :north -> :west' do
      bot.place(0, 0, :north)
      expect {bot.left}.to change {bot.current_position.direction}.from(:north).to(:west)
    end

    it 'solves :east -> :north' do
      bot.place(0, 0, :east)
      expect {bot.left}.to change {bot.current_position.direction}.from(:east).to(:north)
    end

    describe 'without a place command' do

      it 'ignores the command and logs the action' do
        expect(logger).to receive(:info)
        expect {bot.left}.to_not change {bot.current_position}
      end
    end
  end

  describe '#right' do

    it 'solves :north -> :east' do
      bot.place(0, 0, :north)
      expect {bot.right}.to change {bot.current_position.direction}.from(:north).to(:east)
    end

    it 'solves :west -> :north' do
      bot.place(0, 0, :west)
      expect {bot.right}.to change {bot.current_position.direction}.from(:west).to(:north)
    end

    describe 'without a place command' do

      it 'ignores the command' do
        expect(logger).to receive(:info)
        expect {bot.right}.to_not change {bot.current_position}
      end
    end
  end

  describe '#report' do

    it 'reports the current_position' do
      bot.place(0, 0, :east)
      expect(logger).to receive(:info)
      printed = capture_stdout {bot.report}
      expect(printed.chop).to eq("[0, 0] facing: east")
    end

    describe 'without a place command' do

      it 'ignores the command and does not emit to STDOUT' do
        expect(logger).to receive(:info)
        printed = capture_stdout {bot.report}
        expect(printed).to be_empty
      end
    end
  end


end
