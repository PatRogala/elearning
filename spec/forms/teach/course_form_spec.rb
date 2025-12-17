require "rails_helper"

RSpec.describe Teach::CourseForm do
  let(:course) { create(:course) }
  let(:form) { described_class.new(course) }

  describe "validations" do
    it "validates presence of title" do
      form.title = nil
      expect(form).not_to be_valid
    end
  end

  describe "#image=" do
    let(:file) { Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/files/image.jpg"), "image/jpeg") }

    it "attaches the image to the model" do
      allow(course.image).to receive(:attach)
      form.image = file

      expect(course.image).to have_received(:attach).with(file)
    end

    it "does nothing if file is blank" do
      allow(course.image).to receive(:attach)
      form.image = nil

      expect(course.image).not_to have_received(:attach)
    end
  end

  describe "#price=" do
    it "sets price_cents on the model from a decimal string" do
      form.price = "10.50"
      expect(course.price_cents).to eq(1050)
    end

    it "sets price_cents correctly from a float" do
      form.price = 20.00
      expect(course.price_cents).to eq(2000)
    end
  end

  describe "#price" do
    it "returns the amount from the model price" do
      course.price_cents = 3050
      expect(form.price).to eq(30.50)
    end
  end
end
