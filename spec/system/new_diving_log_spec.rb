require 'rails_helper'

RSpec.describe "NewLog", type: :system , js: true do
  let(:user) { FactoryBot.create(:user) }

  before do
    login_as(user)
    visit new_diving_log_path
  end

  scenario "Creating new log fails with invalid information" do
    expect do
      page.accept_confirm do
        click_on :post_button
      end
      expect(has_css?('.alert-danger')).to be_truthy
      expect(current_path).to eq diving_logs_path
    end.to change(DivingLog, :count).by(0)
  end

  scenario "Creating new log success with valid information" do
    fill_in "diving_log_dive_number",  with: 1
    fill_in "address",                 with: "東京"
    fill_in "diving_log_entry_bar",    with: 200
    fill_in "diving_log_exit_bar",     with: 100
    fill_in "diving_log_ave_depth",    with: 15.6
    fill_in "diving_log_max_depth",    with: 25.7
    fill_in "diving_log_comment",      with: "Lorem ipsum"
    expect do
      page.accept_confirm do
        click_on :post_button
      end
      expect(has_css?('.alert-success')).to be_truthy
      expect(current_path).to eq user_path(user)
    end.to change(DivingLog, :count).by(1)
  end
end