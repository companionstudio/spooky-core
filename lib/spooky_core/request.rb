module SpookyCore
  class Request
    include HTTParty
    headers 'Accept' => 'text/xml'
    headers 'Content-Type' => 'text/xml'
    base_uri("https://core.spreedly.com/v1")
    format :xml

    def self.configure(login, secret, gateway)
      config[:login], config[:secret], config[:gateway] = login, secret, gateway
      basic_auth(login, secret)
    end

    def self.config
      @@config ||= {}
    end
  end
end
