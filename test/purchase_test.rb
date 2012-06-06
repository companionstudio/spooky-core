require File.join(File.expand_path(File.dirname(__FILE__)), 'test_helper')

class PurchaseTest < Test::Unit::TestCase
  def setup
    VCR.use_cassette('payment_methods') do
      @valid_payment_method = create_payment_method
      @invalid_payment_method = create_payment_method(:missing_name)
    end
  end

  def test_successful_purchase
    VCR.use_cassette('purchases') do
      transaction = @valid_payment_method.purchase(10, 'AUD')
      assert(transaction.succeeded?)
    end
  end

  def test_unsuccessful_purchase
    VCR.use_cassette('purchases') do
      transaction = @invalid_payment_method.purchase(10, 'AUD')
      assert(transaction.succeeded? == false)
    end
  end

  def test_purchase_unsuccessful_purchase_with_float
    VCR.use_cassette('purchases') do
      transaction = @valid_payment_method.purchase(10.20, 'AUD')
      assert(transaction.succeeded? == false)
      assert(transaction.errors.empty? == false)
      assert(transaction.errors.has_key?(:amount))
    end
  end
end
