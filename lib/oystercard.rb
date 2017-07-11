class Oystercard

  MAXIMUM_BALANCE = 90

  attr_reader :balance, :travelling

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "The maximum you can top up is #{MAXIMUM_BALANCE}" if (amount + balance) > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= 10
  end

  def touch_in
    @travelling = true
  end

  def touch_out
    @travelling = false
  end

  def in_journey?
    @travelling
  end

end
