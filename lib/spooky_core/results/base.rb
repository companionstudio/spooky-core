module SpookyCore
  module Results
    class Base
      attr_reader :errors, :transaction, :credit_card

      def initialize(succeeded, transaction, errors = {}, card = nil)
        @succeeded   = succeeded
        @transaction = transaction
        @errors      = errors
        @credit_card = card
      end

      def succeeded?
        @succeeded
      end
    end
  end
end
