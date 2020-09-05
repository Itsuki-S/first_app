require 'rails_helper'

RSpec.describe "SiteLayouts", type: :system do
  describe "home layout" do

    it "returns title with Home | Diver's Log" do
      visit root_path
      expect(page).to have_title "Home | Diver's Log"
    end

    it "contains root link" do
      visit root_path
      expect(page).to have_link nil, href: root_path, count: 4
    end

    it "contains login link" do
      visit root_path
      expect(page).to have_link 'Sign Up!', href: signup_path
    end
  end

  describe "about layout" do
    it "returns title with About | Diver's Log" do
      visit about_path
      expect(page).to have_title "About | Diver's Log"
    end
  end
end