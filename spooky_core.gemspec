Gem::Specification.new do |s|
  s.name        = 'spooky_core'
  s.version     = '0.6.3'
  s.summary     = "A simple wrapper for the Spreedly Core API V1."
  s.description = "Much longer explanation of the example!"
  s.authors     = ["Ben Hull", "Luke Sutton"]
  s.email       = 'ben@companionstudio.com.au'
  s.homepage    = 'http://github.com/companionstudio/spooky_core'

  s.files = [
    "LICENSE",
    "README",
    "lib/spooky_core.rb",
    *Dir.glob("lib/spooky_core/*.rb")
  ]

  s.add_runtime_dependency 'httparty', '>= 0.15.6'
  s.add_runtime_dependency 'nokogiri', '>= 1.8.2'
end
