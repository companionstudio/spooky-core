module Spec
  module Helpers
    REDIRECTION_URL = "http://localhost:3000/process"

    def create_env(url, params)
      begin
        response = HTTParty.post(url, :body => params, :no_follow => true)
      rescue HTTParty::RedirectionTooDeep => e
        match = e.response.body.match(/href="(.*?)"/)
        if match
          Rack::MockRequest.env_for(CGI.unescapeHTML(match[1]))
        else
          raise "Could not find token on response:\n #{e.response.body}"
        end
      end
    end

    def config_braintree
      SpookyCore.configure(
        :braintree,
        :merchant_id => ENV["BRAINTREE_MERCHANT_ID"],
        :public_key  => ENV["BRAINTREE_PUBLIC_KEY"],
        :private_key => ENV["BRAINTREE_PRIVATE_KEY"]
      )
    end

    def braintree_payment(amount, values)
      tr_data = ::Braintree::TransparentRedirect.transaction_data(
        :redirect_url => REDIRECTION_URL, 
        :transaction => {:type => "sale", :amount => amount}
      )

      params = {
        :tr_data => tr_data,
        :transaction => {:credit_card => values}
      }

      create_env(::Braintree::TransparentRedirect.url, params)
    end

    def spreedly_payment

    end
  end
end

RSpec.configure do |config|
  include Spec::Helpers
  config.order = "random"
end
