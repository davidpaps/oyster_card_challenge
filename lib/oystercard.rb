class Oystercard

  attr_accessor :balance, :in_journey, :entrance_station
  attr_reader :deduct

  MAX_CAP = 90
  MIN = 1
  MIN_CHARGE = 1


  def initialize
    @balance = 0
    @in_journey = false
    @entrance_station = nil
  end

  def top_up(money)
    fail "Maximum limit of #{MAX_CAP} reached" if (@balance + money) > MAX_CAP
    @balance += money
  end

  def touch_in(station)
    fail "insufficent funds" if @balance < MIN
    @in_journey = true
    @entrance_station = station
  end

  def in_journey?
    @in_journey
  end

  def touch_out
    deduct(MIN_CHARGE)
    @in_journey = false
    @entrance_station = nil
  end

  # def entrance_station
  #   @entrance_station
  # end

  private

  def deduct(fare)
    @balance -= fare
  end

end
