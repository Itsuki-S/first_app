require 'rails_helper'

RSpec.describe "SiteLayouts", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:diving_log) { FactoryBot.create(:diving_log) }
  let!(:private_diving_log) { FactoryBot.create(:diving_log, :non_published) }

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
      expect(page).to have_link 'Sign up!', href: signup_path
    end

    it "has diving_log feed" do
      login_as(user)
      visit root_path
      expect(page).to have_link "このログの詳細を見る", href: diving_log_path(diving_log)
    end

    it "doesn't show any non-published posts" do
      login_as(user)
      visit root_path
      expect(page).to_not have_link "このログの詳細を見る", href: diving_log_path(private_diving_log)
    end
  end

  describe "about layout" do
    it "returns title with About | Diver's Log" do
      visit about_path
      expect(page).to have_title "About | Diver's Log"
    end
  end
end