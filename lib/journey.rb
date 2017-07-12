class Journey

  PENALTY_FARE = 6
  FARE = 1

  attr_reader :entry_station, :exit_station

  def initialize(entry_station = nil)
    @entry_station = entry_station
  end

  def complete?
    (!!@entry_station && !!@exit_station) || (!@entry_station && !@exit_station)
  end

  def fare
    complete? ? FARE : PENALTY_FARE
  end

  def finish(exit_station)
    @exit_station = exit_station
    self
  end

end
