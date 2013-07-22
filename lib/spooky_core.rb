require 'httparty'
require 'nokogiri'
require 'braintree'

require 'spooky_core/credit_card'
require 'spooky_core/providers'
require 'spooky_core/results'

# Base module which provides an interface for globally configuring a service,
# then interacting with it in order to make vault credit cards, make payments
# etc.
module SpookyCore
  # A shortcut for looking up provider implementations based on a symbol.
  PROVIDERS = {
    :braintree => Providers::Braintree
  }

  # This method is for globally configuring SpookyCore to use a specific 
  # service, with a single set of credentials.
  #
  # @param [:spreedly_core, :braintree] provider
  # @param Hash opts
  #
  # @return nil
  #
  # @raises [DuplicateConfigurationError, ProviderNotFoundError]
  #
  # @todo Document the specific options for each provider.
  def self.configure(provider_key, opts)
    # raise DuplicateConfigurationError if provider
    @provider = PROVIDERS[provider_key]
    # raise ProviderNotFoundError if provider.nil?
    provider.configure(opts)

    nil
  end

  def self.provider
    @provider
  end
end
