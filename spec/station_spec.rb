require 'station'

describe Station do

    describe 'initialisation' do

        it { is_expected.to respond_to(:name) }

        it { is_expected.to respond_to(:zone) }

    end

end