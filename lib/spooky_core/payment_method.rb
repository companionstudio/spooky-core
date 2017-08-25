module SpookyCore
  class PaymentMethod
    include XmlHelpers

    attr_reader :token, :details

    def self.find(token)
      response = Request.get("/payment_methods/#{token}.xml")
      new(response.body)
    end

    def initialize(xml)
      create_doc('payment_method', xml)
    end

    def valid?
      errors.empty?
    end

    def token
      at('token')
    end

    def first_name
      at('first_name')
    end

    def last_name
      at('last_name')
    end

    def full_name
      at('full_name')
    end

    def number
      at('number')
    end

    def verification_value
      at('verification_value')
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

    def card_type
      at('card_type')
    end

    def purchase(amount, currency = 'USD')
      Transaction.create_from_payment_method('purchase', token, amount, currency)
    end

    def authorize(amount, currency = 'USD')
      Transaction.create_from_payment_method('authorize', token, amount, currency)
    end
  end
end
