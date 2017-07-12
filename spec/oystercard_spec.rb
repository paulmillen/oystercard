require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }
  before :each { allow(oystercard).to receive(:balance_low?) { false } }
  let(:station_in) {:station_in}
  let(:station_out) {:station_out}


  describe '#initialize' do

    it 'will initialize with a balance of 0' do
      expect(oystercard.balance).to eq 0
    end

    it 'will start with an empty journey_log' do
      expect(oystercard.journey_log).to be_empty
    end
  end

  describe '#top_up' do

    it 'tops up the balance' do
      expect { oystercard.top_up(10) }.to change { subject.balance }.by 10
    end

    it 'will not make the balance greater than 90' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      oystercard.top_up(maximum_balance)
      expect { oystercard.top_up(1) }.to raise_error "The maximum you can top up is #{maximum_balance}"
    end
  end

  describe '#touch_in' do

    it 'starts a journey' do
      oystercard.touch_in(station_in)
      expect(oystercard).to be_in_journey
    end

    it 'will fail if balance is less than fare' do
      allow(oystercard).to receive(:balance_low?) { true }
      expect { oystercard.touch_in(station_in) }.to raise_error 'Your balance is insufficent'
    end
  end

  describe '#touch_out' do

    before(:each) { oystercard.top_up(Oystercard::FARE) }
    before(:each) { oystercard.touch_in(station_in) }

    it 'ends a journey' do
      oystercard.touch_out(station_out)
      expect(oystercard).not_to be_in_journey
    end

    it 'deducts the fare' do
      expect { oystercard.touch_out(station_out) }.to change { oystercard.balance }.by Oystercard::FARE * -1
    end
  end

  describe '#current_journey' do

    it 'shows all previous journeys' do
      oystercard.touch_in(station_in)
      oystercard.touch_out(station_out)
      expect(oystercard.journey_log).to eq 1 => [station_in,station_out]
    end
  end

end
