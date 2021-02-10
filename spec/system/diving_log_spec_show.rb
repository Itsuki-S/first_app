require 'rails_helper'

RSpec.describe "diving_log_show", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:diving_log) { FactoryBot.create(:diving_log, :image_attached, user: user) }
  
  scenario "Show diving_log page is shown properly with img" do
    login_as(user)
    click_on :detail_button
    aggregate_failures do
      expect(page).to have_content "Dive No.1"
      expect(page).to have_link user.name
      expect(page).to have_content "記載なし"
      expect(page).to have_selector 'img'
      expect(page).to have_selector 'h3', text: diving_log.address
      expect(page).to have_selector 'h3', text: "60分"
      expect(page).to have_selector 'h3', text: "#{diving_log.entry_bar}bar"
      expect(page).to have_selector 'h3', text: "#{diving_log.exit_bar}bar"
      expect(page).to have_selector 'h3', text: "100bar"
      expect(page).to have_selector 'h3', text: "#{diving_log.ave_depth}m"
      expect(page).to have_selector 'h3', text: "#{diving_log.max_depth}m"
    end
  end
end