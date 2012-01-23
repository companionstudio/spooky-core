require File.join(File.expand_path(File.dirname(__FILE__)), 'test_helper')

class PaymentMethodTest < Test::Unit::TestCase
  def setup
    @valid_payment_method = create_payment_method
    @invalid_payment_method = create_payment_method(:first_name => nil)
  end

  def test_has_correct_data
    details = DEFAULT_OPTS[:credit_card]

    assert_equal(@valid_payment_method.first_name, details[:first_name])
    assert_equal(@valid_payment_method.last_name, details[:last_name])
    assert_equal(@valid_payment_method.month, details[:month])
    assert_equal(@valid_payment_method.year, details[:year])
  end

  def test_captures_errors
    assert(@invalid_payment_method.errors.empty? == false, "Should have errors")
    assert(@invalid_payment_method.errors[:first_name].nil? == false, "First name should have errors")
  end
end
