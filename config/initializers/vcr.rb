return unless Rails.env.test?

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.ignore_localhost = true
  config.hook_into :webmock
end
