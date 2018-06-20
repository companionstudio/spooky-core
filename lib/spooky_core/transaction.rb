module SpookyCore
  class Transaction
    include XmlHelpers

    Error = Struct.new(:attribute, :type, :message)

    def self.create_from_transaction(action, token, body = {})
      options = {body: body.to_xml}
      response = Request.post("/transactions/#{token}/#{action}.xml", options)
      Transaction.new(response.body)
    end

    def self.create_from_payment_method(action, token, amount, currency = 'USD')
      params = Nokogiri::XML::Builder.new do |xml|
        xml.transaction {
          xml.transaction_type(action)
          xml.payment_method_token(token)
          xml.amount(amount)
          xml.currency_code(currency)
        }
      end

      response = Request.post("/gateways/#{Request.config[:gateway]}/#{action}.xml", :body => params.to_xml)
      Transaction.new(response.body)
    end

    def self.find(token)

    end

    def initialize(xml)
      create_doc('transaction', xml)
    end

    def credit
      self.class.create_from_transaction('credit', token)
    end

    def capture
      self.class.create_from_transaction('capture', token)
    end

    def void
      self.class.create_from_transaction('void', token)
    end

    def token
      at('token')
    end

    def transaction_type
      at('transaction_type')
    end

    def amount
      at('amount', :to_i)
    end

    def currency_code
      at('currency_code')
    end

    def succeeded?
      at('succeeded') == 'true'
    end

    def message
      at('message')
    end

    def error_messages
      @error_messages ||= errors.map {|k, v| v.map(&:message)}
    end

    def errors
      @errors ||= begin
        errors = Hash.new {|h, k| h[k] = []}

        # The errors elements contain information about problems that occured before the transaction was attempted.
        @doc.css('errors error').each do |e|
          attribute = e.attribute('attribute').value.to_sym
          type      = e.attribute('key').value.split('.').last.to_sym
          message   = e.inner_text
          errors[attribute] << Error.new(attribute, type, message)
        end

        #Messages elements may also contain error info returned by the gateway
        unless succeeded?
          @doc.css('message').each do |m|
            if m.attribute('key')
              attribute = m.attribute('key').value.to_sym
              type = m.attribute('key').value.split('.').last.to_sym
              message = m.inner_text
              errors[attribute] << Error.new(attribute, type, message)
            end
          end
        end

        errors
      end
    end
  end # Transaction
end # SpookyCore
