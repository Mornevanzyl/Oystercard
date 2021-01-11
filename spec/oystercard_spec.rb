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
          expect { card.top_up(1) }.to raise_error "Card limit of £#{described_class::CARD_LIMIT} reached"
        end
    end

end
