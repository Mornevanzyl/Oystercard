require 'journey'
require "station"

describe Journey do
  let(:station1) { Station.new("Waterloo", "1") }
  let(:station2) { Station.new("Euston", "1") }

  it { is_expected.to respond_to :entry_station }
  it { is_expected.to respond_to :exit_station }
  it { is_expected.to respond_to :fare }

  subject(:journey) { described_class.new(station1, nil) }
  it "returns penalty fare" do
    expect(journey.fare).to eq described_class::PENALTY_FARE
  end

  describe "completed journeys" do
    subject(:journey) { described_class.new(station1, station2) }

    it "returns minimum fare" do
      expect(journey.fare).to eq described_class::MIN_FARE
    end
  end


end