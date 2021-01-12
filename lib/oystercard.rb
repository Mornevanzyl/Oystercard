require 'station'

class OysterCard

   CARD_LIMIT = 90
   MIN_BALANCE = 1

    attr_reader :balance, :in_use, :entry_station

    private
    attr_writer :balance, :in_use

    public

    def initialize
        @balance = 0
        @in_use = false
        @entry_station = ""
    end

    def top_up(amount)
      fail "Card limit of £#{CARD_LIMIT} reached" if limit_exceeded?(amount)
        self.balance = balance + amount
    end


    def touch_in(station)
        fail "Insufficient funds" if balance < MIN_BALANCE
        self.in_use = true
        @entry_station = station
    end

    def touch_out
        self.in_use = false
        deduct(1)
    end

    def in_journey?
        in_use
    end

    private

    def deduct(amount)
        self.balance -= amount
    end

    def limit_exceeded?(amount)
      balance + amount > CARD_LIMIT
    end
end
