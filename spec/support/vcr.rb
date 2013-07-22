VCR.configure do |c|
  c.cassette_library_dir = File.join(File.dirname(__FILE__), '../vcr_cassettes')
  c.hook_into :webmock
  c.default_cassette_options = {
    :match_requests_on  => [:method, :uri, :body],
    :record             => :new_episodes 
  }
end
