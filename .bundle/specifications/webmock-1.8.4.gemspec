# -*- encoding: utf-8 -*-
# stub: webmock 1.8.4 ruby lib

Gem::Specification.new do |s|
  s.name = "webmock".freeze
  s.version = "1.8.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Bartosz Blimke".freeze]
  s.date = "2012-03-19"
  s.description = "WebMock allows stubbing HTTP requests and setting expectations on HTTP requests.".freeze
  s.email = ["bartosz.blimke@gmail.com".freeze]
  s.homepage = "http://github.com/bblimke/webmock".freeze
  s.rubyforge_project = "webmock".freeze
  s.rubygems_version = "2.6.13".freeze
  s.summary = "Library for stubbing HTTP requests in Ruby.".freeze

  s.installed_by_version = "2.6.13" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<addressable>.freeze, [">= 2.2.7"])
      s.add_runtime_dependency(%q<crack>.freeze, [">= 0.1.7"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.8"])
      s.add_development_dependency(%q<httpclient>.freeze, [">= 2.2.4"])
      s.add_development_dependency(%q<patron>.freeze, [">= 0.4.18"])
      s.add_development_dependency(%q<em-http-request>.freeze, [">= 1.0.2"])
      s.add_development_dependency(%q<curb>.freeze, [">= 0.8.0"])
      s.add_development_dependency(%q<typhoeus>.freeze, [">= 0.3.3"])
      s.add_development_dependency(%q<excon>.freeze, [">= 0.11.0"])
      s.add_development_dependency(%q<minitest>.freeze, [">= 2.2.2"])
      s.add_development_dependency(%q<rdoc>.freeze, ["> 3.5.0"])
    else
      s.add_dependency(%q<addressable>.freeze, [">= 2.2.7"])
      s.add_dependency(%q<crack>.freeze, [">= 0.1.7"])
      s.add_dependency(%q<rspec>.freeze, ["~> 2.8"])
      s.add_dependency(%q<httpclient>.freeze, [">= 2.2.4"])
      s.add_dependency(%q<patron>.freeze, [">= 0.4.18"])
      s.add_dependency(%q<em-http-request>.freeze, [">= 1.0.2"])
      s.add_dependency(%q<curb>.freeze, [">= 0.8.0"])
      s.add_dependency(%q<typhoeus>.freeze, [">= 0.3.3"])
      s.add_dependency(%q<excon>.freeze, [">= 0.11.0"])
      s.add_dependency(%q<minitest>.freeze, [">= 2.2.2"])
      s.add_dependency(%q<rdoc>.freeze, ["> 3.5.0"])
    end
  else
    s.add_dependency(%q<addressable>.freeze, [">= 2.2.7"])
    s.add_dependency(%q<crack>.freeze, [">= 0.1.7"])
    s.add_dependency(%q<rspec>.freeze, ["~> 2.8"])
    s.add_dependency(%q<httpclient>.freeze, [">= 2.2.4"])
    s.add_dependency(%q<patron>.freeze, [">= 0.4.18"])
    s.add_dependency(%q<em-http-request>.freeze, [">= 1.0.2"])
    s.add_dependency(%q<curb>.freeze, [">= 0.8.0"])
    s.add_dependency(%q<typhoeus>.freeze, [">= 0.3.3"])
    s.add_dependency(%q<excon>.freeze, [">= 0.11.0"])
    s.add_dependency(%q<minitest>.freeze, [">= 2.2.2"])
    s.add_dependency(%q<rdoc>.freeze, ["> 3.5.0"])
  end
end
