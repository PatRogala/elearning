require_relative "html_normalizer"

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.ignore_localhost = true
  config.hook_into :webmock

  # Nice RSpec integration: `:vcr` metadata auto-creates cassettes.
  config.configure_rspec_metadata!

  config.register_request_matcher :normalized_html_body do |r1, r2|
    norm = ->(req) { HtmlNormalizer.normalize(req.body.to_s) }
    r1.method == r2.method && r1.uri == r2.uri && norm.call(r1) == norm.call(r2)
  end

  # Make cassettes stable:
  config.default_cassette_options = {
    record: :once, # record once, replay afterwards
    match_requests_on: %i[method uri normalized_html_body] # match requests on method, uri, and normalized body
  }

  config.before_record do |i|
    i.request.body = HtmlNormalizer.normalize(i.request.body) if i.request.body
    i.request.headers.delete("User-Agent")
    i.response.headers.delete("Date")
    i.response.headers.delete("Server")
  end
end
