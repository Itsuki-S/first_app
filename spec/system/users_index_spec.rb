require 'rails_helper'

RSpec.describe "UsersIndexSpecs", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:others) {FactoryBot.create_list(:other_user, 31)}

  scenario 'Index has pagination' do
    login_as(user)
    visit users_path
    aggregate_failures do
      expect(current_path).to eq users_path
      expect(page).to have_selector('ul.pagination', count: 2)
      first_page_of_users = User.page(1)
      first_page_of_users.each do |tester|
        expect(page).to have_link(tester.name, href: user_path(tester))
      end
    end
  end
end
