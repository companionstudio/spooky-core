Gem::Specification.new do |s|
  s.name        = 'spooky_core'
  s.version     = '0.7'
  s.summary     = "A simple wrapper for credit card vaulting/payment services."
  s.description = %{
                    Provides a simplified interface for interacting with card 
                    vaulting and payment services which provide transparent 
                    redirect.

                    Currently supports:
                    
                    - Spreedly Core
                    - Braintree
                  }
  s.authors     = ["Luke Sutton", "Ben Hull"]
  s.email       = 'lukeandben@spookandpuff.com'
  s.homepage    = 'http://github.com/spookandpuff/spooky_core'

  s.files = [
    "LICENSE",
    "README",
    "lib/spooky_core.rb",
    *Dir.glob("lib/spooky_core/**/*.rb")
  ]

  s.add_runtime_dependency 'httparty',  '0.11.0'
  s.add_runtime_dependency 'nokogiri',  '1.6.0'
  s.add_runtime_dependency 'braintree', '2.24.0'

  s.add_development_dependency 'rspec',   '2.14.1'
  s.add_development_dependency 'vcr',     '2.5.0'
  s.add_development_dependency 'webmock', '1.11.0'
  s.add_development_dependency 'yard',    '0.8.6.2'
  s.add_development_dependency 'rack',    '1.5.2'
end
