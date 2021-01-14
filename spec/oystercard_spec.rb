require 'oystercard'
require 'station'
require "journey"


describe OysterCard do
  subject(:oystercard) {described_class.new}
#   let(:station) {double :station}
    # let(:journey) {double :journey}
    let(:station) {Station.new("Test Station", "1")}

    it { is_expected.to respond_to(:balance) }

    describe 'initialization' do

        it 'has a numeric balance' do
            expect(oystercard.balance).to be_an(Numeric)
        end
        
        it { is_expected.to respond_to(:journeys) }

        it 'initialises journeys with an empty array' do
            expect(oystercard.journeys).to be_empty
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
    
        before(:each) do
            oystercard.top_up(described_class::MIN_BALANCE)
            oystercard.touch_in(station)
            # allow(:journey).to receive(:entry_station).and_return(station)
        end

        it { is_expected.to respond_to(:touch_in) }
    
        # Move upon refactoring
        it 'raises an error when you .touch_in without the minimum balance' do
            card = OysterCard.new
            expect { card.touch_in(station) }.to raise_error 'Insufficient funds'
        end


        it 'updates the in_use variable to true' do
            expect(oystercard).to be_in_journey
        end

        it "remembers the station that it .touch_in'd at" do
          expect(oystercard.journeys[-1].entry_station.name).to eq "Test Station"
        end

    end

    describe '#touch_out' do
        
        before(:each) do     
          oystercard.top_up(OysterCard::MIN_BALANCE)
          oystercard.touch_in("station")
        end

        it { is_expected.to respond_to(:touch_out) }
        
        it 'updates the in_journey to confirm trip status' do

            oystercard.touch_out("station")
            expect(oystercard).not_to be_in_journey
        end

        it 'should deduct the minimum fare from the card balance' do
            expect{oystercard.touch_out("station")}.to change{oystercard.balance}.by(-1)
        end

        it 'should increase the count of journeys array by 1' do
            oystercard.touch_out("station")
            expect(oystercard.journeys.count).to eq 1
        end

    end

    describe '#in_journey?' do

        it { is_expected.to respond_to(:in_journey?) }

        it 'returns true or false based on the in_use instance variable' do
            subject.top_up(10)
            subject.touch_in("station")
            expect(subject.in_journey?).to eq true
        end

    end
    

end
