require 'journeylog'

describe JourneyLog do


  let(:journey) { double :journey, :entry_station => 'entry_station', :exit_station => 'exit_station' }
  let(:station) { :station }
  let(:journey_class) { double :journey_class, :new => journey }
  subject(:journeylog) { described_class.new(journey_class) }

  describe '#start' do

    it 'starts a journey' do
      expect(journey_class).to receive(:new).with(station)
      journeylog.start(station)
    end
  end

  describe '#finish' do

    it 'stores the journey in journeys' do
      journeylog.start(journey.entry_station)
      journeylog.finish(journey.exit_station)
      expect(journeylog.journeys).to eq [journey]
    end
  end




end
