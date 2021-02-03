FactoryBot.define do
  factory :user, class: User do
    name { "TestUser" }
    sequence(:email) { |n| "testuser#{n}@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }

    trait :admin do
      admin { true }
    end
  end

  factory :other_user, class: User do
    name { "OtherUser" }
    sequence(:email) { |n| "tester#{n}@example.co.jp" }
    password { "foobaz" }
    password_confirmation { "foobaz" }
  end
end