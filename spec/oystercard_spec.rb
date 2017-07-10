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
      oystercard.top_up(10)
      expect(oystercard.balance).to eq 10
    end

    it 'will not make the balance greater than 90' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      oystercard.top_up(maximum_balance)
      expect { oystercard.top_up(1) }.to raise_error "The maximum you can top up is #{maximum_balance}"
    end
  end

  describe '#deduct' do
    it 'will deduct from the balance' do
      oystercard.deduct(10)
      expect(oystercard.balance).to eq -10
    end
  end

end
