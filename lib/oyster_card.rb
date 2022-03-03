require_relative 'journey'

class Oystercard 
  def initialize
    @balance = 0
    @journey_list = []
  end 

  attr_reader :balance, :journey_list, :current_journey
  LIMIT = 90

  def top_up(value)
    raise "Your balance is now £#{@balance}. Maximum limit of £90 reached" if limit_reached?
    @balance += value
  end

  def touch_in(station)
    raise "Insufficient balance" if @balance < Journey::FARE
    @current_journey = Journey.new(station)
  end

  def touch_out(station)
    @current_journey = Journey.new if @current_journey == nil
    @current_journey.finish(station)
    deduct(@current_journey.fare) 



    # comes later
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