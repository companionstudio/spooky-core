require 'test/unit'
require 'yaml'
require 'cgi'
require 'rubygems'

dir = File.expand_path(File.dirname(__FILE__))
require File.join(dir, '../lib/spooky_core')

CONFIG = YAML.load_file(File.join(dir, 'config.yml'))
SpookyCore.configure(CONFIG['login'], CONFIG['secret'], CONFIG['gateway_token'])

def create_payment_method(opts)
  begin
    response = HTTParty.post(
      "https://spreedlycore.com/v1/payment_methods",
      :body => opts,
      :no_follow => true
    )
  rescue HTTParty::RedirectionTooDeep => e
    if e.response.body =~ /href="(.*?)"/
      CGI::parse(URI.parse($1).query)["token"].first
    else
      raise "Could not find token on response:\n #{e.response.body}"
    end
  end
end
