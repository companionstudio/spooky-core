require File.join(File.expand_path(File.dirname(__FILE__)), 'test_helper')

class AuthorizationTest < Test::Unit::TestCase
  def setup
    VCR.use_cassette('authorization') do
      @valid_payment_method = create_payment_method
      @failed_payment_method = create_payment_method(:failed)
    end
  end

  def test_successful_authorization
    VCR.use_cassette('authorization') do
      transaction = @valid_payment_method.authorize(10, 'AUD')
      assert(transaction.succeeded?)
    end
  end

  def test_unsuccessful_authorization
    VCR.use_cassette('authorization') do
      transaction = @failed_payment_method.authorize(10, 'AUD')
      assert(transaction.succeeded? == false)
    end
  end

  def test_authorization_unsuccessful_authorization_with_float
    VCR.use_cassette('authorization') do
      transaction = @valid_payment_method.authorize(10.20, 'AUD')
      assert(transaction.succeeded? == false)
      assert(transaction.errors.empty? == false)
      assert(transaction.errors.has_key?(:amount))
    end
  end
  
  def test_successful_void
    VCR.use_cassette('authorization') do
      authorized = @valid_payment_method.authorize(10, 'AUD')
      
      assert(authorized.succeeded?)

      void = SpookyCore::Transaction.create_from_transaction('void', authorized.token)

      assert(void.succeeded?) #Failing at the moment, because the spreedly core test gateway doesn't support voiding.
    end
  end

  #TODO: Add a test case for a failed void (possibly by altering the amount?)

  def test_successful_capture
    VCR.use_cassette('authorization') do
      authorized = @valid_payment_method.authorize(10, 'AUD')
      assert(authorized.succeeded?)

      capture = SpookyCore::Transaction.create_from_transaction('capture', authorized.token)
      assert(capture.succeeded?)
    end
  end

  #TODO: Add a test case for a failed capture (possibly by altering the amount?)

end
