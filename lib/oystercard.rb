class Oystercard

  MAXIMUM_BALANCE = 90
  FARE = 1

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "The maximum you can top up is #{MAXIMUM_BALANCE}" if (amount + balance) > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in
    fail 'Your balance is insufficent' if balance < FARE
    @travelling = true
  end

  def touch_out
    deduct(FARE)
    @travelling = false
  end

  def in_journey?
    @travelling
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
