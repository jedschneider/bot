describe Board do

  it 'defines the size of the board' do
    board = Board.new(5, 5)
    expect(board.dimensions).to eq([5, 5])
  end

  describe "#on_board?" do

    let(:board) {Board.new(5, 5)}

    it 'returns true when a position is on the board' do
      position = double(:position, coordinates: [4, 0])
      expect(board.on_board?(position)).to eq(true)
    end

    it 'returns true when on the edge of board' do
      position = double(:position, coordinates: [5, 0])
      expect(board.on_board?(position)).to eq(true)
    end

    it 'returns false when off the board' do
      position = double(:position, coordinates: [0, 6])
      expect(board.on_board?(position)).to eq(false)
    end
  end

  describe '#next_position' do

    let(:board) {Board.new(5, 5)}

    describe 'when next position is on the board' do

      it 'can return a new position' do
        current_position = double(:position, x: 0, y: 0)
        position         = board.next_position(current_position, :east, 1)
        expect(position.coordinates).to eq([1, 0])
      end

      describe 'switching direction' do

        it 'can move to the west' do
          current_position = double(:position, x: 1, y: 0)
          position         = board.next_position(current_position, :west, 1)
          expect(position.coordinates).to eq([0, 0])
        end

        it 'can move to the south' do
          current_position = double(:position, x: 1, y: 1)
          position         = board.next_position(current_position, :south, 1)
          expect(position.coordinates).to eq([1, 0])
        end

        it 'can move to the north' do
          current_position = double(:position, x: 1, y: 1)
          position         = board.next_position(current_position, :north, 1)
          expect(position.coordinates).to eq([1, 2])
        end

        it 'can move to the east' do
          current_position = double(:position, x: 1, y: 1)
          position         = board.next_position(current_position, :east, 1)
          expect(position.coordinates).to eq([2, 1])
        end
      end
    end

    describe 'when next position is off the board' do

      it 'will raise an OutOfBoundsError' do
        current_position = double(:position, x: 5, y: 0, coordinates: [5, 0])
        expect {
          board.next_position(current_position, :east, 1)
        }.to raise_exception(OutOfBoundsError)
      end
    end
  end
end
