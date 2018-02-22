describe Position do

  let(:position) {Position.new(0, 0, :east)}

  it 'initializes and sets accessors' do
    expect(position.x).to eq(0)
    expect(position.y).to eq(0)
    expect(position.direction).to eq(:east)
  end

  describe '#coordinates' do

    it 'reports its coordinates' do
      expect(position.coordinates).to eq([0, 0])
    end
  end

  describe '#to_s' do

    it 'has a sensible to_s' do
      expect(position.to_s).to eq("[0, 0] facing: east")
    end
  end
end
