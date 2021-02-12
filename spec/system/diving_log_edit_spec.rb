require 'rails_helper'

RSpec.describe "diving_log_edit", type: :system, js: true do
  let(:user) {FactoryBot.create(:user)}
  let!(:diving_log) {FactoryBot.create(:diving_log, user: user)}

  before do
    login_as(user)
    visit edit_diving_log_path(diving_log)
  end

  scenario "Editing a log fails with invalid information" do
    fill_in "diving_log_dive_number",  with: ""
    fill_in "address",                 with: ""
    fill_in "diving_log_entry_bar",    with: ""
    fill_in "diving_log_exit_bar",     with: ""
    fill_in "diving_log_ave_depth",    with: ""
    fill_in "diving_log_max_depth",    with: ""
    page.accept_confirm do
      click_on :post_button
    end
    expect(has_css?('.alert-danger')).to be_truthy
    expect(current_path).to eq diving_log_path(diving_log)
  end

  scenario "Editing a log succeeds with valid information" do
    fill_in "diving_log_dive_number",  with: 2
    fill_in "address",                 with: "東京"
    fill_in "diving_log_entry_bar",    with: 190
    fill_in "diving_log_exit_bar",     with: 110
    fill_in "diving_log_ave_depth",    with: 16.6
    fill_in "diving_log_max_depth",    with: 26.7
    fill_in "diving_log_comment",      with: "Ipsum lorem"
    page.accept_confirm do
      click_on :post_button
    end
    expect(has_css?('.alert-success')).to be_truthy
    expect(current_path).to eq user_path(user)
  end

  scenario "A log is properly deleted when delete button pushed" do
    expect do
      page.accept_confirm do
        click_on :delete_button
      end
      expect(has_css?('.alert-success')).to be_truthy
    end.to change(DivingLog, :count).by(-1)
    expect(current_path).to eq user_path(user)
  end
end