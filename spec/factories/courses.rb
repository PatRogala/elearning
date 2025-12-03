FactoryBot.define do
  factory :course do
    title { Faker::Educator.course_name }
    instructor { association :user }
  end
end
