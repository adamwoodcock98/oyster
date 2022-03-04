class JourneyLog

  attr_reader :journey

  def initialize(journey_class = nil)
    @journeys = []
    @journey = journey_class
  end

  def start(station)
    @journey = current_journey
    add_entry_station(station)
  end

  def finish(station)
    @journey = current_journey
    add_exit_station(station)
    save_journey
  end

  def journeys
    @journeys
  end

  private 

  def current_journey
    @journey = @journey || Journey.new
  end

  def add_entry_station(station)
    @journey.entry_station = station
  end

  def add_exit_station(station)
    @journey.exit_station = station
  end

  def save_journey
    @journeys << @journey
  end

end