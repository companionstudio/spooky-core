module SpookyCore
  module Providers
    class Base
      # Configures the provider.
      #
      # @param Hash opts
      #
      # @return SpookyCore::Providers::Base
      def self.configure(opts)
        raise NotImplementedError
      end

      # Retrieves the payment method details from the provider's vault.
      #
      # @param String id
      #
      # @return [SpookyCore::CreditCard, nil]
      def self.credit_card(id)
        raise NotImplementedError
      end

      # Retrieves the transaction details from the provider's vault.
      #
      # @param String id
      #
      # @return [SpookyCore::Transaction, nil]
      def self.transaction(id)
        raise NotImplementedError
      end

      # Used to confirm the submission of payment details to a provider.
      # Depending on the specific provider and the configuration, this step may
      # simply store the payment details, pre-authorise or bill.
      #
      # @param Rack::Env env
      #
      # @return SpookyCore::Results::Confirmation
      def self.confirm_post(env)
        raise NotImplementedError
      end

      # Voids an authorization. 
      #
      # @param Hash opts
      # 
      # @return SpookyCore::Results::Void
      def self.void(opts)
        raise NotImplementedError
      end

      # Authorizes a payment.
      #
      # @param Hash opts
      # 
      # @return SpookyCore::Results::Authorize
      def self.authorize(opts)
        raise NotImplementedError
      end

      # Bills a payment method.
      #
      # @param SpookyCore::CreditCard payment_method
      # @param [String, Numeric] amount
      # @param Hash opts
      # 
      # @return SpookyCore::Results::Authorize
      def self.bill(payment_method, amount, opts = {})
        raise NotImplementedError
      end

      # Captures funds that have been pre-authorized.
      #
      # @param SpookyCore::CreditCard payment_method
      # @param String transaction_id
      # @param Hash opts
      # 
      # @return SpookyCore::Results::Bill
      def self.capture(payment_method, transaction_id, opts)
        raise NotImplementedError
      end

      # Credits a payment method with the specified amount.
      #
      # @param SpookyCore::CreditCard payment_method
      # @param [String, Numeric] amount
      # @param Hash opts
      #
      # @return SpookyCore::Results::Credit
      def self.credit(payment_method, amount, opts = {})
        raise NotImplementedError
      end

      # Removes payment details from the provider's vault.
      #
      # @param SpookyCore::CreditCard payment_method
      # @param Hash opts
      # 
      # @return SpookyCore::Results::Redact
      def self.redact(payment_method, opts = {})
        raise NotImplementedError
      end
    end
  end
end
