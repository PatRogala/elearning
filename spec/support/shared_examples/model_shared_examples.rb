# Shared examples for common Rails model testing patterns
RSpec.shared_examples "a valid factory" do |factory_name = nil|
  before do
    factory_name ||= described_class.name.underscore.to_sym
  end

  it "has a valid factory" do
    expect(build(factory_name)).to be_valid
  end

  it "can be created" do
    expect { create(factory_name) }.not_to raise_error
  end

  it "can be built without database writes" do
    expect { build_stubbed(factory_name) }.not_to raise_error
  end

  it "can be created multiple times without conflicts" do
    expect do
      create(factory_name)
      create(factory_name)
    end.not_to raise_error
  end
end

RSpec.shared_examples "a model with presence validation" do |attribute|
  it "validates presence of #{attribute}" do
    expect(subject).to validate_presence_of(attribute)
  end
end

RSpec.shared_examples "a model with uniqueness validation" do |attribute|
  it "validates uniqueness of #{attribute}" do
    expect(subject).to validate_uniqueness_of(attribute)
  end
end

RSpec.shared_examples "a model with uniqueness scope validation" do |subject, attribute, scope|
  it "validates uniqueness of #{attribute} with scope #{scope}" do
    create(subject) # Existing record to test against
    expect(build(subject)).to validate_uniqueness_of(attribute).scoped_to(scope)
  end
end

RSpec.shared_examples "a model with belongs_to association" do |association|
  it { expect(subject).to belong_to(association) }
end
