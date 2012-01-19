module SpookyCore
  class PaymentMethod
    attr_reader :token, :details

    def initialize(token)
      @token = token
      @details = Request.get("/payment_methods/#{token}.xml")
    end

    def retain

    end

    def reverse(amount, currency = 'USD')
      Request.transaction('reverse', @token, amount, currency)
    end

    def purchase(amount, currency = 'USD')
      Request.transaction('purchase', @token, amount, currency)
    end

    def authorize(amount, currency = 'USD')
      Request.transaction('authorize', @token, amount, currency)
    end

    def capture(token)
      Request.transaction('capture', @token, amount, currency)
    end
  end
end
