require 'oystercard'
# require_relative './station'


describe OysterCard do
  subject(:oystercard) {described_class.new}
  let(:station) {double :station}


    it { is_expected.to respond_to(:balance) }

    describe 'initialization' do

        it 'has a numeric balance' do
            expect(oystercard.balance).to be_an(Numeric)
        end

    end

    describe '#top_up' do

        it { is_expected.to respond_to(:top_up).with(1).argument }

        it 'increases the balance with the amount passed as an argument' do
            card = OysterCard.new
            card.top_up(15)
            expect(card.balance).to eq 15
        end

        it "raises an exception when the new balance exceeds the limit" do
          card = OysterCard.new
          card.top_up(described_class::CARD_LIMIT)
          expect { card.top_up(OysterCard::MIN_BALANCE) }.to raise_error "Card limit of £#{described_class::CARD_LIMIT} reached"
        end
    end

    describe '#deduct' do

        it 'responds to #deduct' do
            expect(respond_to subject.send(:deduct, 10))
        end

        it 'checks that fare is correctly deducted from balance' do
            card = OysterCard.new
            card.top_up(10)
            expect(card.send(:deduct, 10)).to eq 0
        end

    end

    describe '#touch_in' do
        it { is_expected.to respond_to(:touch_in) }

        it 'updates the in_use variable to true' do
            card = OysterCard.new
            card.top_up(OysterCard::MIN_BALANCE)
            card.touch_in("station")
            expect(card).to be_in_journey
        end

        it 'raises an error when you .touch_in without the minimum balance' do
          expect { subject.touch_in("station") }.to raise_error 'Insufficient funds'
        end

        it "remembers the station that it .touch_in'd at" do
        #   station = double('station')
          allow(station).to receive(:name) { "Amersham"}
          card = OysterCard.new
          card.top_up(OysterCard::MIN_BALANCE)
          card.touch_in("Amersham")
          expect(card.entry_station).to eq station.name
        end

    end

    describe '#touch_out' do

        it { is_expected.to respond_to(:touch_out) }

        it 'updates the in_use variable to false' do

            card = OysterCard.new
            card.top_up(OysterCard::MIN_BALANCE)
            card.touch_in("station")
            card.touch_out
            expect(card).not_to be_in_journey
        end

        it 'should deduct the minimum fare from the card balance' do
            expect{subject.touch_out}.to change{subject.balance}.by(-1)
        end

    end

    describe '#in_journey?' do

        it { is_expected.to respond_to(:in_journey?) }

        it 'returns true or false based on the in_use instance variable' do
            card = OysterCard.new
            expect(card.in_journey?).to eq false
        end

    end

end
