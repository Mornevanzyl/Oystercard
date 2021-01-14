require 'journey'

describe Journey do

  subject(:journey) { described_class.new(nil, nil) }
  it { is_expected.to respond_to :entry_station }
  it { is_expected.to respond_to :exit_station }


end