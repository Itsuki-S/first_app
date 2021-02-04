require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  let(:user) { FactoryBot.create(:user) }

  before { user.create_reset_digest }

  describe "Get /password_resets" do
    it "returns http success" do
      get new_password_reset_path
      aggregate_failures do
        expect(response).to have_http_status(:success)
        expect(response.body).to include  'Forgot password'
      end
    end
  end

  describe "Post /password_resets" do
    it "fails with invalid email" do
      post password_resets_path, params: { password_reset: { email: "" } }
      aggregate_failures do
        expect(flash[:danger]).to be_truthy
        expect(response).to redirect_to new_password_reset_path
      end
    end

    it "succeeds with valid email" do
      post password_resets_path, params: { password_reset: { email: user.email } }
      aggregate_failures do
        expect(flash[:info]).to be_truthy
        expect(ActionMailer::Base.deliveries.size).to eq 1
        expect(response).to redirect_to root_path
      end
    end

    it "fails with non-activated" do
      user.toggle!(:activated)
      post password_resets_path, params: { password_reset: { email: user.email } }
      aggregate_failures do
        expect(flash[:danger]).to be_truthy
        expect(response).to redirect_to new_password_reset_path
      end
    end
  end

  describe "Get /password_resets/:id/edit" do
    it "fails with right token and invalid email" do
      get edit_password_reset_path(user.reset_token, email: "")
      expect(response).to redirect_to root_path
    end

    it "fails with wrong token and valid email" do
      get edit_password_reset_path("wrong", email: user.email)
      expect(response).to redirect_to root_path
    end

    it "succeeds with right token and valid email" do
      get edit_password_reset_path(user.reset_token, email: user.email)
      aggregate_failures do
        expect(response).to have_http_status(200)
        expect(response.body).to include "Reset password"
      end
    end

    it "fails with non-activated user" do
      user.toggle!(:activated)
      get edit_password_reset_path(user.reset_token, email: user.email)
      expect(response).to redirect_to root_url
    end
  end

  describe "PATCH /password_resets/:id" do
    it "fails with wrong password confirmation" do
      patch password_reset_path(user.reset_token),
              params: {
                email: user.email,
                user: {
                  password: "foobar",
                  password_confirmation: "barbaz",
                },
              }
      aggregate_failures do
        expect(response).to have_http_status(200)
        expect(response.body).to include "Reset password"
      end
    end

    it "fails with blank password" do
      patch password_reset_path(user.reset_token),
              params: {
                email: user.email,
                user: {
                  password: "",
                  password_confirmation: "",
                },
              }
      aggregate_failures do
        expect(response).to have_http_status(200)
        expect(response.body).to include "Reset password"
      end
    end

    it "succeeds with valid password and password confirmation" do
      patch password_reset_path(user.reset_token),
              params: {
                email: user.email,
                user: {
                  password: "foobaz",
                  password_confirmation: "foobaz",
                },
              }
      aggregate_failures do
        expect(is_logged_in?).to be_truthy
        expect(flash[:success]).to be_truthy
        expect(response).to redirect_to user
      end
    end

    it "fails when expired" do
      user.update_attribute(:reset_sent_at, 3.hours.ago)
      patch password_reset_path(user.reset_token),
            params: {
              email: user.email,
              user: {
                password: "foobar",
                password_confirmation: "foobar",
              },
            }
      expect(response).to redirect_to new_password_reset_url
    end
  end
end
