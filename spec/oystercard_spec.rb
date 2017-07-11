require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }
  before :each { allow(oystercard).to receive(:balance_low?) { false } }
  let(:station) {:station}

  describe '#initialize' do

    it 'will initialize with a balance of 0' do
      expect(oystercard.balance).to eq 0
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
      oystercard.touch_in(station)
      expect(oystercard).to be_in_journey
    end

    it 'will fail if balance is less than fare' do
      allow(oystercard).to receive(:balance_low?) { true }
      expect { oystercard.touch_in(station) }.to raise_error 'Your balance is insufficent'
    end

    it 'remembers the entry station' do
      oystercard.top_up(Oystercard::FARE)
      oystercard.touch_in(station)
      expect(oystercard.entry_station).to eq station
    end
  end

  describe '#touch_out' do

    it 'ends a journey' do
      oystercard.top_up(Oystercard::FARE)
      oystercard.touch_in(station)
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end

    it 'deducts the fare' do
      expect { oystercard.touch_out }.to change { oystercard.balance }.by Oystercard::FARE * -1
    end

    it 'removes the entry_station' do
      oystercard.top_up(Oystercard::FARE)
      oystercard.touch_in(station)
      expect { oystercard.touch_out }.to change { oystercard.entry_station }.to eq nil
    end
  end

end
