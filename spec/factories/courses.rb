FactoryBot.define do
  factory :course do
    title { Faker::Educator.course_name }
    instructor { association :user }
    image { Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/files/image.jpg"), "image/jpeg") }
  end
end
