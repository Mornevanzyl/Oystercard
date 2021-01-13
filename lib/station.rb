class Station
  attr_reader :name, :zone

  def initialize(name="Unknown", zone="?")
    @name = name
    @zone = zone
  end

end
