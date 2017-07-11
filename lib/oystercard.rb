class Oystercard

  MAXIMUM_BALANCE = 90
  FARE = 1

  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "The maximum you can top up is #{MAXIMUM_BALANCE}" if (amount + balance) > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail 'Your balance is insufficent' if balance_low?
    @entry_station = station
  end

  def touch_out
    deduct(FARE)
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def balance_low?
    balance < FARE
  end

end
