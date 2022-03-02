require_relative 'journey'

class Oystercard 
  def initialize
    @balance = 0
    @journey_list = []
    @current_journey = Journey.new
  end 

  attr_reader :balance, :journey_list, :current_journey
  LIMIT = 90

  def top_up(value)
    raise "Your balance is now £#{@balance}. Maximum limit of £90 reached" if limit_reached?
    @balance += value
  end

  def touch_in(station)
    raise "Insufficient balance" if @balance < @current_journey.fare #will be dependent on Journey class
  end

  def touch_out(station)
    deduct(@current_journey.fare) #will be dependent on Journey
    @journey_list << { :journey => Journey.new } # need updating
  end

  private

  def deduct(value)
    @balance -= value
  end

  def limit_reached?
    @balance >= LIMIT
  end 
end