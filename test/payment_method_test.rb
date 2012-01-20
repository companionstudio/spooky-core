require File.join(File.expand_path(File.dirname(__FILE__)), 'test_helper')

class PaymentMethodTest < Test::Unit::TestCase
  def setup
    @year = Time.now.year + 1
    token = create_payment_method(
      :api_login    => CONFIG['login'],
      :redirect_url => "http://derp.com",
      :credit_card  => {
        :first_name         => "John",
        :last_name          => "Doe",
        :card_type          => :master,
        :number             => '4111111111111111',
        :verification_value => 123,
        :month              => 4,
        :year               => @year
      }
    )

    @payment_method = SpookyCore::PaymentMethod.new(token)
  end

  def test_has_correct_data
    assert_equal(@payment_method.first_name, 'John')
    assert_equal(@payment_method.last_name, 'Doe')
    assert_equal(@payment_method.month, 4)
    assert_equal(@payment_method.year, @year)
  end

  def test_captures_errors

  end
end
