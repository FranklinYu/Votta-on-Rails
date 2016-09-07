FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    password Faker::Internet.password
  end

  factory :session do
    user
    comment Faker::Lorem.sentence(3)
  end
end
