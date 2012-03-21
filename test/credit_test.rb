require File.join(File.expand_path(File.dirname(__FILE__)), 'test_helper')

class CreditTest < Test::Unit::TestCase
  def setup
    VCR.use_cassette('payment_methods') do
      @valid_payment_method = create_payment_method
    end
  end

  def test_successful_credit
    VCR.use_cassette('credits') do
      purchase = @valid_payment_method.purchase(1000, 'AUD')
      assert(purchase.succeeded?)

      credit = SpookyCore::Transaction.create_from_transaction('credit', purchase.token)
      assert(purchase.succeeded?)
    end
  end
end
