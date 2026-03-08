FactoryBot.define do
  factory :lesson do
    title { Faker::Lorem.sentence }
    position { Faker::Number.between(from: 1, to: 100) }
    course
  end
end
