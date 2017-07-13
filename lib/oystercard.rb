class Oystercard

  require_relative './journey'

  MAXIMUM_BALANCE = 90

  attr_reader :balance, :journey_log

  def initialize
    @balance = 0
    @journey_log = {}
    @trip_counter = 1
    @current_journey = Journey.new
  end

  def top_up(amount)
    fail "The maximum you can top up is #{MAXIMUM_BALANCE}" if (amount + balance) > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
      deduct(@current_journey.fare) unless @current_journey.fare == 1
      fail 'Your balance is insufficent' if balance_low?
      @current_journey = Journey.new(station)
  end

  def touch_out(station)
    @current_journey.finish(station)
    deduct(@current_journey.fare)
    @journey_log[@trip_counter] = @current_journey
    @trip_counter += 1
    @current_journey = Journey.new
  end

  def in_journey?
    !@current_journey.complete?
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def balance_low?
    balance < Journey::FARE
  end

end
