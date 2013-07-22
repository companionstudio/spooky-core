dir = File.expand_path(File.dirname(__FILE__))
env = File.join(dir, '../env.rb')

begin
  require 'bundler/setup'
rescue LoadError
  puts "Bundler not available, using installed gems"
end

require 'rspec'
require 'vcr'
require 'webmock'
require 'rack'
require 'cgi'
require env if File.exists?(env)
require File.join(dir, '../lib/spooky_core')
Dir[File.join(dir, "support/*.rb")].each {|f| require f}

module Spec
  module Braintree; end
  module SpreedlyCore; end
end
