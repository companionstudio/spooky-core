require 'httparty'
require 'nokogiri'

dir = File.expand_path(File.join(File.dirname(__FILE__)))
require File.join(dir, 'spooky_core/errors')
require File.join(dir, 'spooky_core/request')
require File.join(dir, 'spooky_core/xml_helpers')
require File.join(dir, 'spooky_core/payment_method')
require File.join(dir, 'spooky_core/transaction')

module SpookyCore
  VERSION = '0.1'

  def self.configure(login, secret, gateway)
    Request.configure(login, secret, gateway)
  end
end
