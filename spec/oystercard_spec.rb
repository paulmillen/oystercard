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

  describe '#deduct' do

    it 'will deduct from the balance' do
      expect { oystercard.deduct(10) }.to change { subject.balance }.by -10
    end
  end

  describe '#touch_in' do

    it 'starts a journey' do
      expect { oystercard.touch_in }.to change { oystercard.travelling }
    end
  end

  describe '#touch_out' do

    it 'ends a journey' do
      expect { oystercard.touch_out }.to change { oystercard.travelling }
    end
  end

  describe '#in_journey?' do

    it 'is true if touched in' do
      oystercard.touch_in
      expect(oystercard.in_journey?).to eq true
    end

    it 'is false if touched in' do
      oystercard.touch_out
      expect(oystercard.in_journey?).to eq false
    end
  end




end
