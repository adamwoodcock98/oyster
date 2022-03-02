class Journey

  attr_reader :in_journey, :entry_station, :exit_station #maybe needs initialising again
  FARE = 1
  PENALTY = 6

  def initialize(station = nil)
    @entry_station = station
  end

  def in_journey?
    entry_station != nil
  end

  def fare
    return FARE if complete?
    return PENALTY 
  end

  def finish(station = nil)
    @exit_station = station
    self
  end

  def complete?
    @entry_station != nil && @exit_station != nil
  end


  # @entry_station = station # from touch in method

  # @exit_station = station # from touch out method
  # @entry_station = nil # from touch out method


end