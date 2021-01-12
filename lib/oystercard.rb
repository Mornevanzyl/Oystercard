class OysterCard

   CARD_LIMIT = 90

    attr_reader :balance, :in_use

    private
    attr_writer :balance, :in_use

    public

    def initialize
        @balance = 0
        @in_use = false
    end

    def top_up(amount)
      fail "Card limit of £#{CARD_LIMIT} reached" if limit_exceeded?(amount)
        self.balance = balance + amount
    end

    def deduct(amount)
        self.balance -= amount
    end

    def touch_in
        self.in_use = true
    end

    def touch_out
        self.in_use = false
    end

    def in_journey?
        in_use
    end

    private

    def limit_exceeded?(amount)
      balance + amount > CARD_LIMIT
    end
end
