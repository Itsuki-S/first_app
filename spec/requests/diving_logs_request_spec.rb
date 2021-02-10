require 'rails_helper'

RSpec.describe "DivingLogs", type: :request do
  let(:user) {FactoryBot.create(:user)}
  let(:diving_log) {FactoryBot.create(:diving_log)}

  describe "DivingLog#new" do
    it "fails and redirects user to login_url when not logged in" do
      get new_diving_log_path
      expect(response).to redirect_to login_path
    end
  end

  describe "DivingLog#show" do
    it "fails and redirects user to login_url when not logged in" do
      get diving_log_path(diving_log)
      expect(response).to redirect_to login_path
    end
  end

  describe "Divinglog#create" do
  let(:image_path) { File.join(Rails.root, 'spec/fixtures/test.jpg') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }
    it "fails and redirects user to login_url when not logged in" do
      expect do
        post diving_logs_path, params: { diving_log: { 
          dive_number: 1,
          address: "東京",
          entry_time: 1.hour.ago,
          exit_time: Time.zone.now,
          entry_bar: 200,
          exit_bar: 100,
          ave_depth: 15.6,
          max_depth: 25.7,
          comment: "Lorem ipsum",
          images: image
         } }
      end.to change(DivingLog, :count).by(0)
      expect(response).to redirect_to login_path
    end

    it "success with an image when logged in" do
      log_in_as(user)
      expect do
        post diving_logs_path, params: { diving_log: { 
          dive_number: 1,
          address: "東京",
          entry_time: 1.hour.ago,
          exit_time: Time.zone.now,
          entry_bar: 200,
          exit_bar: 100,
          ave_depth: 15.6,
          max_depth: 25.7,
          comment: "Lorem ipsum",
          images: image
         } }
      end.to change(DivingLog, :count).by(1)
      expect(response).to redirect_to user_path(user)
      expect(user.diving_logs.last.images).not_to be nil
    end
  end
end
