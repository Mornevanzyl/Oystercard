require 'station'

class OysterCard

   CARD_LIMIT = 90
   MIN_BALANCE = 1

    attr_reader :balance, :entry_station

    private
    attr_writer :balance

    public

    def initialize
        @balance = 0
        @entry_station = nil
    end

    def top_up(amount)
      fail "Card limit of £#{CARD_LIMIT} reached" if limit_exceeded?(amount)
        self.balance = balance + amount
    end


    def touch_in(station)
        fail "Insufficient funds" if balance < MIN_BALANCE
        @entry_station = station
    end

    def touch_out
        deduct(1)
        @entry_station = nil
    end

    def in_journey?
        @entry_station != nil
    end

    private

    def deduct(amount)
        self.balance -= amount
    end

    def limit_exceeded?(amount)
      balance + amount > CARD_LIMIT
    end
end
