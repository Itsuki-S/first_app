require 'rails_helper'

RSpec.describe "SiteLayouts", type: :system do
  describe "home layout" do
    it "contains root link" do
      visit root_path
      expect(page).to have_link nil, href: root_path
    end

    it "contails login link" do
      visit root_path
      expect(page).to have_link 'Sign In!', href: login_path
    end
  end
end