class JourneyLog

  require '/Users/Paul/Makers/Projects/oystercard/lib/journey'

  attr_reader :current_journey, :journeys

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journeys = []
    @current_journey = nil
  end

  def start(entry_station)
    @current_journey = @journey_class.new(entry_station)
  end

  def finish(exit_station)
    @journeys << @current_journey.finish(exit_station)
    @current_journey = nil
  end

end
