class Oystercard

  attr_accessor :balance, :entrance_station, :exit_station
  attr_reader :deduct, :journey_history
  

  MAX_CAP = 90
  MIN = 1
  MIN_CHARGE = 1


  def initialize
    @balance = 0
    @entrance_station = nil
    @journey_history = []
    @exit_station
  end

  def top_up(money)
    fail "Maximum limit of #{MAX_CAP} reached" if (@balance + money) > MAX_CAP
    @balance += money
  end

  def touch_in(station)
    fail "insufficent funds" if @balance < MIN
    @entrance_station = station
  end

  def in_journey?
    @entrance_station != nil
  end

  def touch_out(station)
    deduct(MIN_CHARGE)
    @exit_station = station
    @journey_history << { entry_station:  @entrance_station, exit_station: @exit_station}
    @entrance_station = nil
  end


  private


  def deduct(fare)
    @balance -= fare
  end

end
