require_relative 'journey'

class Oystercard 
  def initialize(journey_log = JourneyLog.new)
    @balance = 0
    @journey_list = []
    @journey_log = journey_log
  end 

  attr_reader :balance, :journey_list, :current_journey
  LIMIT = 90

  def journey_log
    @journey_log
  end
  def top_up(value)
    raise "Your balance is now £#{@balance}. Maximum limit of £90 reached" if limit_reached?
    @balance += value
  end

  def touch_in(station)
    raise "Insufficient balance" if @balance < Journey::FARE
    deduct(Journey::PENALTY) if @journey_log.journey != nil
    @journey_log.start(station)
  end

  def touch_out(station)
    @journey_log.finish(station)
    deduct(@journey_log.journey.fare)
  end

  private


  def deduct(value)
    @balance -= value
  end

  def limit_reached?
    @balance >= LIMIT
  end 
end