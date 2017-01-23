# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
  end

  factory :session do
    user
    comment { Faker::Lorem.sentence(3) }
  end

  factory :topic do
    user
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
  end

  factory :candidate do
    user
    topic
    body { Faker::Lorem.paragraph }
  end

  factory :vote do
    user
    candidate
  end
end
