return unless Rails.env.test?

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.ignore_localhost = true
  config.hook_into :webmock

  # Nice RSpec integration: `:vcr` metadata auto-creates cassettes.
  config.configure_rspec_metadata!

  # Make cassettes stable:
  config.default_cassette_options = {
    record: :once, # record once, replay afterwards
    match_requests_on: %i[method uri body] # match requests on method, uri, and body
  }

  config.before_record do |i|
    i.request.headers.delete("User-Agent")
    i.response.headers.delete("Date")
    i.response.headers.delete("Server")
  end
end
