require_relative "oystercard"

class Journey

  attr_reader :journey

  MIN_CHARGE = 1
  PENALTY_CHARGE = 6

  def initialize
    @journey = {entry_station: nil, exit_station: nil}
  end

  def start_journey(station)
    reset_card unless complete?
    @journey[:entry_station] = station
  end

  def finish_journey(station)
    reset_card if complete?
    @journey[:exit_station] = station
  end

  def complete?
    @journey[:exit_station] != nil && @journey[:entry_station] != nil
  end

  def reset_card
    @journey = {entry_station: nil, exit_station: nil}
  end

  def fare
    complete? ? MIN_CHARGE : PENALTY_CHARGE
  end
  
end