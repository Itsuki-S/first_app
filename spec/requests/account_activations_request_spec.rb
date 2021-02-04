require 'rails_helper'

RSpec.describe "AccountActivations", type: :request do
  let(:user) { FactoryBot.create(:user, :no_activated) }

  it "fail when user sends right token and wrong email" do
    get edit_account_activation_path(
      user.activation_token,
      email: "invalid@email.com",
    )
    expect(is_logged_in?).to be_falsey
    expect(response).to redirect_to root_url
  end

  it "fail when user sends wrong token and right email" do
    get edit_account_activation_path(
      "wrong activation token",
      email: user.email,
    )
    expect(is_logged_in?).to be_falsey
    expect(response).to redirect_to root_url
  end

  it "succeed when user sends right token and right email" do
    get edit_account_activation_path(
      user.activation_token,
      email: user.email,
    )
    expect(is_logged_in?).to be_truthy
    expect(response).to redirect_to user_path(user)
  end
  
end
