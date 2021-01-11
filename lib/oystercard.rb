class OysterCard

   CARD_LIMIT = 90

    attr_reader :balance

    private
    attr_writer :balance

    public

    def initialize
        @balance = 0
    end

    def top_up(amount)
      fail "Card limit of £#{CARD_LIMIT} reached" if limit_exceeded?(amount)
        self.balance = balance + amount
    end

    private

    def limit_exceeded?(amount)
      balance + amount > CARD_LIMIT
    end
end
