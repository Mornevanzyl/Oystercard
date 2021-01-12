require 'oystercard'

describe OysterCard do

    it { is_expected.to respond_to(:balance) }

    describe 'initialization' do

        it 'has a numeric balance' do
            expect(subject.balance).to be_an(Numeric)
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

        it { is_expected.to respond_to(:deduct).with(1).argument }

        it 'checks that fare is correctly deducted from balance' do
            card = OysterCard.new
            card.top_up(10)
            expect(card.deduct(10)).to eq 0
        end

    end

    describe '#touch_in' do

        it { is_expected.to respond_to(:touch_in) }

        it 'updates the in_use variable to true' do
            card = OysterCard.new
            card.top_up(OysterCard::MIN_BALANCE)
            card.touch_in
            expect(card).to be_in_journey
        end

        it 'raises an error when you .touch_in without the minimum balance' do
          expect { subject.touch_in }.to raise_error 'Insufficient funds'
        end

    end

    describe '#touch_out' do

        it { is_expected.to respond_to(:touch_out) }

        it 'updates the in_use variable to false' do
            card = OysterCard.new
            card.top_up(OysterCard::MIN_BALANCE)
            card.touch_in
            card.touch_out
            expect(card).not_to be_in_journey
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
