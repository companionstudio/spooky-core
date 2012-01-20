module SpookyCore
  class PaymentMethod
    include XmlHelpers

    attr_reader :token, :details

    def initialize(token)
      @token = token
      response = Request.get("/payment_methods/#{token}.xml")
      create_doc('payment_method', response.body)
    end

    def first_name
      at('first_name')
    end

    def last_name
      at('last_name')
    end

    def number
      at('number')
    end

    def payment_method_type
      at('payment_method_type')
    end

    def last_four_digits
      at('last_four_digits')
    end

    def month
      at('month', :to_i)
    end

    def year
      at('year', :to_i)
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
