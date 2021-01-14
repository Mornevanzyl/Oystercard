

class Journey

  MIN_FARE = 1
  PENALTY_FARE = 6

  attr_accessor :entry_station, :exit_station

  def initialize(entry_station, exit_station)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def fare
    PENALTY_FARE
  end

end