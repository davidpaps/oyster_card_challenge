require_relative "station"
require_relative "journey"

class Oystercard

  attr_accessor :balance, :entrance_station, :exit_station
  attr_reader :deduct, :journey_history, :current_journey
  

  MAX_CAP = 90
  MIN = 1
  MIN_CHARGE = 1


  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(money)
    fail "Maximum limit of #{MAX_CAP} reached" if (@balance + money) > MAX_CAP
    @balance += money
  end

  def touch_in(station)
    check_journey
    @current_journey =  Journey.new
    fail "insufficent funds" if @balance < MIN
    # @current_journey = Journey.new
    @current_journey.start_journey(station)
   
  end

  def touch_out(station)
    check_journey
    deduct(MIN_CHARGE)
    @current_journey.finish_journey(station)
    @journey_history << @current_journey.journey
  end

  def check_journey

    if @current_journey != nil
      @current_journey.journey[:exit_station] = nil
      @journey_history << @current_journey.journey
    end

    if @current_journey == nil
      @current_journey = Journey.new
      @current_journey.journey[:entry_station] == nil
    end

  end


  private


  def deduct(fare)
    @balance -= fare
  end

end
