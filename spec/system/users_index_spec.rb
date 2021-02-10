require 'rails_helper'

RSpec.describe "UsersIndexSpecs", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:admin_user) { FactoryBot.create(:user, :admin) }
  let!(:others) {FactoryBot.create_list(:other_user, 31)}
  let!(:no_activated_user) { FactoryBot.create(:user, :no_activated) }

  scenario 'Index has pagination and delete links for admin user' do
    login_as(admin_user)
    visit users_path
    aggregate_failures do
      expect(current_path).to eq users_path
      expect(page).to have_selector('ul.pagination', count: 2)
      first_page_of_users = User.page(1)
      first_page_of_users.each do |tester|
        expect(page).to have_link(tester.name, href: user_path(tester))
        unless tester == admin_user
          expect(page).to have_link('delete', href: user_path(tester))
        end
      end
    end
  end

  scenario 'it dose not show any no_activated user' do
    login_as(user)
    visit users_path
    aggregate_failures do
      expect(current_path).to eq users_path
      expect(page).not_to have_link(no_activated_user.name, href: user_path(no_activated_user))
    end
  end

  scenario 'it has no delete link for non-admin user' do
    login_as(user)
    visit users_path
    expect(page).not_to have_link('delete')
  end
end
