module SpookyCore
  class Request
    include HTTParty
    headers 'Accept' => 'text/xml'
    headers 'Content-Type' => 'text/xml'
    base_uri("https://spreedlycore.com/v1")
    format :xml

    def self.configure(login, secret, gateway)
      config[:login], config[:secret], config[:gateway] = login, secret, gateway
      basic_auth(login, secret)
    end

    def self.config
      @@config ||= {}
    end

    def self.transaction(action, payment_token, amount, currency = 'USD')
      transaction = Nokogiri::XML::Builder.new do |xml|
        xml.transaction {
          xml.transaction_type(action)
          xml.payment_method_token(payment_token)
          xml.amount(amount)
          xml.currency_code(currency)
        }
      end

      # Check to see if the response is a 500, 404 or 403 and raise an
      # appropriate error.
      response = post("/gateways/#{config[:gateway]}/#{action}.xml", :body => transaction.to_xml)
      Transaction.new(response.body)
    end
  end
end
