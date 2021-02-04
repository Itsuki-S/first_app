FactoryBot.define do
  factory :user, class: User do
    name { "TestUser" }
    sequence(:email) { |n| "testuser#{n}@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
    activated { true } 
    activated_at { Time.zone.now }
    
    trait :admin do
      admin { true }
    end

    trait :no_activated do
      activated { false }
      activated_at { nil }
    end
  end
  
  factory :other_user, class: User do
    name { "OtherUser" }
    sequence(:email) { |n| "tester#{n}@example.co.jp" }
    password { "foobaz" }
    password_confirmation { "foobaz" }
    activated { true } 
    activated_at { Time.zone.now }
  end
end