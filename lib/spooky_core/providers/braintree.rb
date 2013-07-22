module SpookyCore
  module Providers
    class Braintree < SpookyCore::Providers::Base
      def self.configure(opts)
        ::Braintree::Configuration.environment  = opts[:environment] || :sandbox
        ::Braintree::Configuration.merchant_id  = opts[:merchant_id]
        ::Braintree::Configuration.public_key   = opts[:public_key]
        ::Braintree::Configuration.private_key  = opts[:private_key]

        self
      end

      def self.credit_card(id)
        begin
          card = ::Braintree::CreditCard.find(id)
          coerce_card(card) if card
        rescue Braintree::NotFoundError
          nil
        end
      end

      # Construct a confirm result
      # Construct a transaction
      # Construct a credit card
      def self.confirm_post(env)
        result = ::Braintree::TransparentRedirect.confirm(env["QUERY_STRING"])
        {
          :transaction => coerce_transaction(result.transaction),
          :credit_cart => coerce_card(result.transaction.credit_card_details),
          :success => result.is_a?(::Braintree::SuccessfulResult)
        }
      end

      def self.capture(payment_method, transaction_id, opts = {})
        result = ::Braintree::Transaction.submit_for_settlement(transaction_id)
      end

      private

      def self.coerce_transaction(transaction)
        {
          :id => transaction.id,
          :type => transaction.type,
          :amount => transaction.amount,
          :status => transaction.status,
          :created_at => transaction.created_at
        }
      end

      def self.coerce_card(card)
        CreditCard.new(
          :id               => card.token,
          :name             => card.cardholder_name,
          :number           => card.masked_number,
          :card_type        => card.card_type,
          :expiration_month => card.expiration_month,
          :expiration_year  => card.expiration_year
        )
      end
    end
  end
end
