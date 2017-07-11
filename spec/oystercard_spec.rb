require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

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
      oystercard.top_up(Oystercard::FARE)
      expect { oystercard.touch_in }.to change { oystercard.travelling }
    end

    it 'will fail if balance is less than fare' do
      expect { oystercard.touch_in }.to raise_error 'Your balance is insufficent'
    end
  end

  describe '#touch_out' do

    it 'ends a journey' do
      expect { oystercard.touch_out }.to change { oystercard.travelling }
    end

    it 'deducts the fare' do
      expect { subject.touch_out }.to change { subject.balance }.by Oystercard::FARE * -1
    end
  end

  describe '#in_journey?' do

    it 'is true if touched in' do
      oystercard.top_up(Oystercard::FARE)
      oystercard.touch_in
      expect(oystercard).to be_in_journey
    end

    it 'is false if touched out' do
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end
  end

end
