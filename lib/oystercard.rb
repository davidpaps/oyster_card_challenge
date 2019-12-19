require_relative "station"
require_relative "journey"

class Oystercard

  attr_accessor :balance, :entrance_station, :exit_station
  attr_reader :deduct, :journey_history, :current_journey
  
  MAX_CAP = 90

  def initialize(journey = Journey.new)
    @balance = 0
    @journey_history = []
    @current_journey = journey
  end

  def top_up(money)
    fail "Maximum limit of #{MAX_CAP} reached" if exceed_max(money)
    @balance += money
  end

  def touch_in(station)
    fail "insufficent funds" if insufficient_balance
    @current_journey.start_journey(station)
    add_to_journey_history
  end

  def touch_out(station)
    deduct(@current_journey.fare)
    @current_journey.finish_journey(station)
    add_to_journey_history unless @current_journey.complete?
  end

  def add_to_journey_history
    @journey_history << @current_journey.journey
  end

  
  private

  def deduct(fare)
    @balance -= fare
  end

  def exceed_max(money)
    (@balance + money) > MAX_CAP
  end

  def insufficient_balance
    @balance < Journey::MIN_CHARGE
  end

end
