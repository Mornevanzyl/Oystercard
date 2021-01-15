

class Journey

  MIN_FARE = 1
  PENALTY_FARE = 6

  attr_accessor :entry_station, :exit_station

  def initialize(entry_station, exit_station)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def fare
    entry_station == nil || exit_station == nil ? PENALTY_FARE : MIN_FARE
  end

end