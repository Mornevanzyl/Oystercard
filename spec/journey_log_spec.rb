require 'journey_log'
require 'journey'
require 'station'

describe JourneyLog do
  # let(:journey) { double entry_station: entry_station, exit_station: exit_station }
  subject { described_class.new }
  # subject(:journeylog) { described_class.new }

  context 'on initialize' do

    it 'accepts journey class as parameter' do
      station = Station.new
      journey = Journey.new(station, station)
      journey_log = JourneyLog.new(journey)
      expect(journey_log.journey_class).to eq(journey)
    end
  end
end
