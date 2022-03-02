class Oystercard 
  def initialize
    @balance = 0
    @in_journey = false
    @entry_station = nil
    @exit_station = nil
    @journey_list = []
  end 

  attr_reader :balance, :in_journey, :entry_station, :exit_station, :journey_list
  LIMIT = 90
  FARE = 1

  def top_up(value)
    raise "Your balance is now £#{@balance}. Maximum limit of £90 reached" if limit_reached?
    @balance += value
  end

  def touch_in(station)
    raise "Insufficient balance" if @balance < FARE
    #@in_journey = true
    @entry_station = station
  end

  def touch_out(station)
    deduct(FARE)
    #@in_journey = false
    @exit_station = station
    @journey_list << {:entry_station => @entry_station, :exit_station => @exit_station}
    @entry_station = nil

  end

  def in_journey?
    entry_station != nil
  end

  

  private

  def deduct(value)
    @balance -= value
  end

  def limit_reached?
    @balance >= LIMIT
  end 
end