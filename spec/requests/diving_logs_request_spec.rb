require 'rails_helper'

RSpec.describe "DivingLogs", type: :request do
  let(:user) {FactoryBot.create(:user)}
  let(:tester) { FactoryBot.create(:user) }               
  let!(:diving_log) {FactoryBot.create(:diving_log, user: user)}
  let!(:private_diving_log) {FactoryBot.create(:diving_log, :non_published)}
  let(:image_path) { File.join(Rails.root, 'spec/fixtures/test.jpg') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }

  describe "DivingLog#new" do
    it "fails and redirects user to login_url when not logged in" do
      get new_diving_log_path
      expect(response).to redirect_to login_path
    end
    
    it "succeeds when logged_in" do
      log_in_as(user)
      get new_diving_log_path
      expect(response).to have_http_status(200)
    end
  end
  
  describe "DivingLog#show" do
    it "fails and redirects user to login_url when not logged in" do
      get diving_log_path(diving_log)
      expect(response).to redirect_to login_path
    end

    it "doesn't show non-published posts for another user" do
      log_in_as(user)
      get diving_log_path(private_diving_log)
      expect(response).to redirect_to root_path
    end
     
    it "succeeds when logged_in" do
      log_in_as(user)
      get diving_log_path(diving_log)
      expect(response).to have_http_status(200)
    end
  end

  describe "Divinglog#create" do
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
         } }
      end.to change(DivingLog, :count).by(0)
      expect(response).to redirect_to login_path
    end

    it "fails to create now log with invalid input" do
      log_in_as(user)
      expect do
        post diving_logs_path, params: { diving_log: { 
          dive_number: "",
          address: "",
          entry_time: "",
          exit_time: "",
          entry_bar: "",
          exit_bar: "",
          ave_depth: "",
          max_depth: "",
         } }
      end.to change(DivingLog, :count).by(0)
      expect(response).to have_http_status(200)
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

  describe 'Divinglog#edit' do
    it "fails and redirects user to login_url when not logged in" do
      get edit_diving_log_path(diving_log)
      expect(response).to redirect_to login_path
    end

    it "succeeds when logged in" do
      log_in_as(user)
      get edit_diving_log_path(diving_log)
      expect(response).to have_http_status(200)
    end

    context "when logged_in user tries to go another user's log-editing page" do
      it "fails and redirects to root_path" do
        log_in_as(tester)
        get edit_diving_log_path(diving_log)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'Divinglog#update' do
    it "fails and redirects user to login_url when not logged in" do
      patch diving_log_path(diving_log), params: { diving_log: { 
        dive_number: 2,
        address: "東京",
        entry_time: 2.hour.ago,
        exit_time: 1.hour.ago,
        entry_bar: 210,
        exit_bar: 110,
        ave_depth: 16.6,
        max_depth: 26.7,
        comment: "Ipsum lorem",
      } }
      expect(response).to redirect_to login_path
    end

    it "fails and redirects user to login_url when user tries to edit another's log" do
      log_in_as(tester)
      patch diving_log_path(diving_log), params: { diving_log: { 
        dive_number: 2,
        address: "東京",
        entry_time: 2.hour.ago,
        exit_time: 1.hour.ago,
        entry_bar: 210,
        exit_bar: 110,
        ave_depth: 16.6,
        max_depth: 26.7,
        comment: "Ipsum lorem",
      } }
      expect(response).to redirect_to root_path
    end

    it "fails to edit log with invalid input" do
      log_in_as(user)
      patch diving_log_path(diving_log), params: { diving_log: { 
        dive_number: "",
        address: "",
        entry_time: "",
        exit_time: "",
        entry_bar: "",
        exit_bar: "",
        ave_depth: "",
        max_depth: "",
      } }
      expect(response).to have_http_status(200)
    end

    it "success with an image when logged in" do
      log_in_as(user)
      patch diving_log_path(diving_log), params: { diving_log: { 
        dive_number: 2,
        address: "東京",
        entry_time: 2.hour.ago,
        exit_time: 1.hour.ago,
        entry_bar: 210,
        exit_bar: 110,
        ave_depth: 16.6,
        max_depth: 26.7,
        comment: "Ipsum lorem",
        images: image
      } }
      expect(response).to redirect_to user_path(user)
      expect(user.diving_logs.last.images).not_to be nil
    end
  end

  describe 'Divinglog#delete' do
    it "deletes no log and redirects to login_path not logged_in" do
      expect do
        delete diving_log_path(diving_log)
      end.to change(DivingLog, :count).by(0)
      expect(response).to redirect_to login_path
    end
    
    context "when logged_in user tries to delete another user's diving_log" do
      it "doesn't delete another's diving_log and redirects to root_path" do
        log_in_as(tester)
        expect do
          delete diving_log_path(diving_log)
        end.to change(DivingLog, :count).by(0)
        expect(response).to redirect_to root_path
      end
    end
  end
end
