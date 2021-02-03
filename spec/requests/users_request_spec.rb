require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:other_user) }

  describe "GET /signup" do
    it "returns http success" do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /signups" do
    it "is invalid signup information" do
      get signup_path
      expect {
        post signup_path, params: {
          user:{
            name: "",
            email: "user@invalid",
            password: "foo",
            password_confirmation: "bar"
          }
        }
      }.not_to change(User, :count)
    end

    it "is valid signup information" do
      get signup_path
      expect {
        post signup_path, params: {
          user: {
            name: "Example User",
            email: "user@example.com",
            password: "password",
            password_confirmation: "password"
          }
        }
      }.to change(User, :count).by(1)
    end
  end

  describe "GET /users/:id" do
    it "redirect to login_path unless logged_in" do
      get edit_user_path(user)
      expect(response).to redirect_to login_path
    end

    it 'redirects to root_path when logged in as other user' do
      log_in_as(other_user)
      get edit_user_path(user)
      expect(response).to redirect_to root_path
    end
  end
  
  describe "Patch /users/:id" do
    it 'redirect to login_path unless logged_in' do
      patch user_path(user), params: { user: {
        name: user.name,
        email: user.email,
        } }
      expect(response).to redirect_to login_path
      end

    it 'fails to edit with incorrect information' do
      log_in_as(user)
      patch user_path(user), params: { user: {
        name: "",
        email: "foo@bar",
        password: "foo",
        password_confirmation: "bar",
      } }
      expect(response).to have_http_status(200)
    end

    it 'redirects to root_path when logged in as another user' do
      log_in_as(other_user)
      patch user_path(user), params: { user: {
        name: user.name,
        email: user.email,
        } }
        expect(response).to redirect_to root_path
    end
    
    it 'fails to edit admin trait via the web' do
      log_in_as(other_user)
      patch user_path(other_user), params: { user: {
        name: other_user.name,
        email: other_user.email,
        admin: true
      } }
      expect(other_user.admin?).to be_falsey
    end
  end

  describe 'Get /users' do
    it 'redirects to login_path when not logged in' do
      get users_path
      expect(response).to redirect_to login_path
    end
  end

  describe 'delete /users/:id' do
    let!(:admin_user) { FactoryBot.create(:user, :admin) }
    it 'fails when logged in as non-admin user' do
      log_in_as(user)
      aggregate_failures do
        expect do
          delete user_path(admin_user)
        end.to change(User, :count).by(0)
        expect(response).to redirect_to root_url
      end
    end

    it 'succeds when user is administrator' do
      log_in_as(admin_user)
      aggregate_failures do
        expect do
          delete user_path(user)
        end.to change(User, :count).by(-1)
        expect(response).to redirect_to users_url
      end
    end
  end
end
