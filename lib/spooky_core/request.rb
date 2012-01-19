module SpookyCore
  class Request
    include HTTParty
    headers 'Accept' => 'text/xml'
    headers 'Content-Type' => 'text/xml'
    base_uri("https://spreedlycore.com/v1")
    format :xml

    def self.configure(login, secret, gateway)
      config[:login], config[:secret], config[:gateway] = login, secret, gateway

      basic_auth(config[:api_login], config[:api_secret])
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

      response = post("/gateways/#{config[:gateway_token]}/#{action}.xml" :body => transaction.to_xml)
      Transaction.new(Nokogiri::XML::Document.new(response))
    end
  end
end
