require File.join(File.expand_path(File.dirname(__FILE__)), 'test_helper')

class PurchaseTest < Test::Unit::TestCase
  def setup
    @valid_payment_method = create_payment_method
    @invalid_payment_method = create_payment_method(:first_name => nil)
  end

  def test_successful_purchase
    transaction = @valid_payment_method.purchase(10, 'AUD')
    assert(transaction.succeeded?)
  end

  def test_unsuccessful_purchase
    transaction = @invalid_payment_method.purchase(10, 'AUD')
    assert(transaction.succeeded? == false)
  end
end
