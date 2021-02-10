require 'rails_helper'

RSpec.describe DivingLog, type: :model do
  
  describe "diving_log" do
    let!(:diving_log) { FactoryBot.create(:diving_log) }

    it "is valid with test data" do
      expect(diving_log).to be_valid
    end

    it "is invalid without user_id" do
      diving_log.user_id = nil
      expect(diving_log).to be_invalid
    end

    it "is invalid without dive_number" do
      diving_log.dive_number = nil
      expect(diving_log).to be_invalid
    end

    it "is invalid without address" do
      diving_log.address = nil
      expect(diving_log).to be_invalid
    end

    it "is invalid without ave_depth" do
      diving_log.ave_depth = nil
      expect(diving_log).to be_invalid
    end

    it "is invalid without max_depth" do
      diving_log.max_depth = nil
      expect(diving_log).to be_invalid
    end
    
    it "is invalid without entry_time" do
      diving_log.entry_time = nil
      expect(diving_log).to be_invalid
    end

    it "is invalid without exit_time" do
      diving_log.exit_time = nil
      expect(diving_log).to be_invalid
    end

    it "is invalid without entry_bar" do
      diving_log.entry_bar = nil
      expect(diving_log).to be_invalid
    end

    it "is invalid without exit_bar" do
      diving_log.exit_bar = nil
      expect(diving_log).to be_invalid
    end
  end

  describe "Sort by latest" do
    let!(:day_before_yesterday) { FactoryBot.create(:diving_log, :day_before_yesterday) }
    let!(:now) { FactoryBot.create(:diving_log) }
    let!(:yesterday) { FactoryBot.create(:diving_log, :yesterday) }

    it "succeeds" do
      expect(DivingLog.first).to eq now
    end
  end

end
