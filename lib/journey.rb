class Journey
  attr_reader :journey

  def initialize
    # @entrance_station = nil
    # @exit_station = nil
    @journey = {entry_station: nil, exit_station: nil}
  end

  def start_journey(station)
    @journey[:entry_station] = station
  end

  def finish_journey(station)
    @journey[:exit_station] = station
  end
  
end