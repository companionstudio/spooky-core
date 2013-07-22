require File.join(File.expand_path(File.dirname(__FILE__)), '../spec_helper')

describe "Braintree transparent redirect" do 
  before(:all) do
    config_braintree
  end

  it "should successfully store details" do
    VCR.use_cassette('braintree_transparent_redirect') do
      env = braintree_payment(
        "10.00",
        :number           => "4111111111111111",
        :expiration_month => "10",
        :expiration_year  => "16",
        :cvv              => "343"
      )

      result = SpookyCore.provider.confirm_post(env)
    end
  end
end
