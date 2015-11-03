require 'test/unit'
require 'yaml'
require 'cgi'
require 'rubygems'
require 'vcr'
require 'webmock'

dir = File.expand_path(File.dirname(__FILE__))
require File.join(dir, '../lib/spooky_core')

VCR.configure do |c|
  c.cassette_library_dir = File.join(dir, 'vcr_cassettes')
  c.hook_into :webmock
  c.default_cassette_options = {
    :match_requests_on  => [:method, :uri, :body],
    :record             => :new_episodes 
  }
end


SpookyCore.configure(ENV['LOGIN'], ENV['SECRET'], ENV['GATEWAY'])

DEFAULT_CC = {
  :first_name         => "John",
  :last_name          => "Doe",
  :number             => '4111111111111111',
  :verification_value => 123,
  :month              => 4,
  :year               => Time.now.year + 1
}

DEFAULT_OPTS = {
  :api_login    => ENV['LOGIN'],
  :redirect_url => "http://derp.com",
  :credit_card  => DEFAULT_CC
}

TEST_CARDS = {
  :success => DEFAULT_CC,
  :missing_name => DEFAULT_CC.merge({:first_name => nil}),
  :failed => DEFAULT_CC.merge({:number => '4012888888881881'})
}

def create_payment_method(card = nil)
  params = DEFAULT_OPTS.dup
  params[:credit_card] = TEST_CARDS[card] if card

  begin
    response = HTTParty.post(
      "https://core.spreedly.com/v1/payment_methods",
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
