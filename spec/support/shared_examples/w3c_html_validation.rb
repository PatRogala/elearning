require "w3c_validators"

require_relative "../html_normalizer"

RSpec.shared_examples "valid HTML", :vcr do
  it "is valid W3C HTML" do
    html = HtmlNormalizer.normalize(response.body)

    validator = W3CValidators::NuValidator.new
    results = validator.validate_text(html)

    expect(results.errors).to be_empty, <<~MSG
      W3C validation errors found:
      #{results.errors.map(&:message).join("\n")}
    MSG
  end
end
