FactoryBot.define do
  factory :role do
    name { Faker::Lorem.unique.word }

    trait :admin do
      name { "Admin" }
    end

    trait :teacher do
      name { "Teacher" }
    end
  end
end
