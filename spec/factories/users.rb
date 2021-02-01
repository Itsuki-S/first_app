FactoryBot.define do
  factory :user, class: User do
    name { "TestUser" }
    sequence(:email) { |n| "testuser#{n}@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
  end
end