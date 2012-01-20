module SpookyCore
  class Transaction
    include XmlHelpers

    def initialize(xml)
      create_doc('transaction', xml)
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

    def error_type
      @error_type ||= begin
        key = @doc.at('transaction/message').attr('key')
        key.split('.')[1].to_sym
      end
    end
  end # Transaction
end # SpookyCore
