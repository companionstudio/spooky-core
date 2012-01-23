require File.join(File.expand_path(File.dirname(__FILE__)), 'test_helper')

class CreditTest < Test::Unit::TestCase
  def setup
    @valid_payment_method = create_payment_method
  end

  def test_successful_credit
    purchase = @valid_payment_method.purchase(10, 'AUD')
    assert(credit.succeeded?)
  end
end
