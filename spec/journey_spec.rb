require 'journey'

describe Journey do

  let(:station) { double :station, zone: 1 }

  it 'initializes with nil if no argument given' do
    expect(subject.entry_station).to eq nil
  end

  context 'given an entry station' do

    subject(:journey) { described_class.new(station) }

    it 'initializes with entry station' do
      expect(journey.entry_station).to eq station
    end

    it 'knows if a journey is not complete' do
      expect(journey).not_to be_complete
    end

    it 'returns a penalty fare if no exit station given' do
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end

    context 'given an exit station' do

      let(:exit_station) { double :exit_station }
      before :each { subject.finish(exit_station) }

      it 'calculates a fare' do
        expect(journey.fare).to eq Journey::FARE
      end

      it 'knows if a journey is complete' do
        expect(journey).to be_complete
      end

      it 'returns itself when exiting a journey' do
        expect(journey.finish(station)).to eq journey
      end
    end
  end

end
