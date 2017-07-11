class Oystercard

  MAXIMUM_BALANCE = 90
  FARE = 1

  attr_reader :balance, :entry_station, :journey_log

  def initialize
    @balance = 0
    @journey_log = {}
    @counter = 1
  end

  def top_up(amount)
    fail "The maximum you can top up is #{MAXIMUM_BALANCE}" if (amount + balance) > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail 'Your balance is insufficent' if balance_low?
    @entry_station = station
  end

  def touch_out(station)
    deduct(FARE)
    @exit_station = station
    current_journey
  end

  def in_journey?
    !!@entry_station
  end

  def current_journey
    @journey_log[@counter] = [@entry_station, @exit_station]
    @entry_station = nil
    @exit_station = nil
    @counter += 1
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def balance_low?
    balance < FARE
  end

end
