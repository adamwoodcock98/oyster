class Journey

  attr_reader :in_journey, :entry_station, :exit_station #maybe needs initialising again
  FARE = 1

  def in_journey?
    entry_station != nil
  end

  def fare
    FARE
  end

  # @entry_station = station # from touch in method

  # @exit_station = station # from touch out method
  # @entry_station = nil # from touch out method


end