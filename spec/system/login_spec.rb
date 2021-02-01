require 'rails_helper'

RSpec.describe "Logins", type: :system do
  let(:user) { FactoryBot.create(:user) }

  context "login with invalid information" do
    it "is invalid because it has no information" do
      visit login_path
      expect(page).to have_selector '.login-container'
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      find(".form-submit").click
      expect(current_path).to eq login_path
      expect(page).to have_selector '.login-container'
      expect(page).to have_selector '.alert-danger'
    end

    it "deletes flash messages when users input invalid information then other links" do
      visit login_path
      expect(page).to have_selector '.login-container'
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      find(".form-submit").click
      aggregate_failures do
        expect(current_path).to eq login_path
        expect(page).to have_selector '.login-container'
        expect(page).to have_selector '.alert-danger'
        visit root_path
        expect(page).not_to have_selector '.alert-danger'
      end
    end
  end

  context "login with valid information" do
    it "is valid because it has valid information" do
      login_as(user)
      aggregate_failures do
        expect(current_path).to eq user_path(1)
        expect(page).not_to have_link 'Login'
        expect(page).to have_link 'Logout'
        expect(page).to have_link 'Profile'
      end
    end
  end
end