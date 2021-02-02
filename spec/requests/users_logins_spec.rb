require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do

  let(:user) { FactoryBot.create(:user) }

  describe "GET /users_logins" do
    it "has a danger flash message because of invalid login information" do
      get login_path
      post login_path, params: {
        session: {
          email: "",
          password: ""
        }
      }
      expect(flash[:danger]).to be_truthy
    end

    it "has no danger flash message because of valid login information" do
      get login_path
      post login_path, params: {
        session: {
          email: user.email,
          password: user.password
        }
      }
      expect(flash[:danger]).to be_falsey
    end
  end

  describe "delete /logout" do
    it 'redirects to root_path' do
      post login_path, params: { session: {
        email: user.email,
        password: user.password,
      } }
      delete logout_path
      aggregate_failures do
        expect(response).to redirect_to root_path
        expect(is_logged_in?).to be_falsy
      end
    end

    it 'succeeds logout when user logs out on multiple tabs' do
      delete logout_path
      aggregate_failures do
        expect(response).to redirect_to root_path
        expect(is_logged_in?).to be_falsy
      end
    end

    it 'succeeds logout when user logs out on multiple tabs' do
      delete logout_path
      aggregate_failures do
        expect(response).to redirect_to root_path
        expect(is_logged_in?).to be_falsy
      end
    end
  end

  describe 'remenber me' do
    it 'saves permanent cookies when remember_me checkbox is checked' do
      log_in_as(user, remember_me: "1")
      expect(cookies[:remember_token]).not_to eq nil
    end

    it "doesn't save permanent cookies when remember_me checkbox isn't checked" do
      delete logout_path
      log_in_as(user, remember_me: "0")
      expect(cookies[:remember_token]).to eq nil
    end

  end
end
