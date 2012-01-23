require 'test/unit'
require 'yaml'
require 'cgi'
require 'rubygems'

dir = File.expand_path(File.dirname(__FILE__))
require File.join(dir, '../lib/spooky_core')

CONFIG = YAML.load_file(File.join(dir, 'config.yml'))
SpookyCore.configure(CONFIG['login'], CONFIG['secret'], CONFIG['gateway_token'])

DEFAULT_CC = {
  :first_name         => "John",
  :last_name          => "Doe",
  :number             => '4111111111111111',
  :verification_value => 123,
  :month              => 4,
  :year               => Time.now.year + 1
}

DEFAULT_OPTS = {
  :api_login    => CONFIG['login'],
  :redirect_url => "http://derp.com",
  :credit_card  => DEFAULT_CC
}

def create_payment_method(opts = nil)
  params = DEFAULT_OPTS.dup
  params[:credit_card] = params[:credit_card].merge(opts) if opts

  begin
    response = HTTParty.post(
      "https://spreedlycore.com/v1/payment_methods",
      :body => params,
      :no_follow => true
    )
  rescue HTTParty::RedirectionTooDeep => e
    if e.response.body =~ /href="(.*?)"/
      SpookyCore::PaymentMethod.find(CGI::parse(URI.parse($1).query)["token"].first)
    else
      raise "Could not find token on response:\n #{e.response.body}"
    end
  end
end
