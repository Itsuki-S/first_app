FactoryBot.define do
  factory :diving_log, class: DivingLog do
    sequence(:dive_number) { |n| "#{n}" }
    entry_time { Time.zone.now }
    exit_time { Time.zone.now + 1.hour }
    address { "東京" }
    entry_bar { "210" }
    exit_bar { "110" }
    ave_depth { "15" }
    max_depth { "25" }
    association :user

    trait :yesterday do
      entry_time { 1.day.ago }
      exit_time { 1.day.ago + 1.hour}
    end

    trait :day_before_yesterday do
      entry_time { 2.day.ago }
      exit_time { 2.day.ago + 1.hour }
    end

    trait :image_attached do
      images {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg'))}
    end
  end
end
