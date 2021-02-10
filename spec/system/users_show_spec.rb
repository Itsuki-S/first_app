require 'rails_helper'

RSpec.describe "UsersShow", type: :system do
  let(:user) { FactoryBot.create(:user) }

  describe 'User profile ' do
    before do
      11.times do |n|
        dive_number = n+1
        address = "東京"
        entry_time = Faker::Time.between(from: (13-n).month.ago, to: (12-n).month.ago)
        exit_time = entry_time + 1.hour
        entry_bar = rand(190..210)
        exit_bar = rand(30..80)
        ave_depth = rand(10..20).round(1)
        max_depth = rand(20..30).round(1)
        comment = Faker::Lorem.paragraphs
        user.diving_logs.create!(
          dive_number: dive_number,
          address: address,
          entry_time: entry_time,
          exit_time: exit_time,
          entry_bar: entry_bar,
          exit_bar: exit_bar,
          ave_depth: ave_depth,
          max_depth: max_depth,
          comment: comment)
      end
      login_as(user)
    end
    it 'is displayed properly' do
      visit user_path(user)
      aggregate_failures do
        expect(current_path).to eq user_path(user)
        expect(page).to have_title full_title(user.name)
        expect(page).to have_selector 'h3', text: user.name 
        expect(page).to have_selector 'img.gravatar'
        expect(page).to have_selector('ul.pagination', count: 2)
        user.diving_logs.all.page(1).each do |diving_log|
          expect(page).to have_link user.name
        end
      end
    end
  end
end