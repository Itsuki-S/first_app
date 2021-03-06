require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "account_activation" do
    let(:user) { FactoryBot.create(:user) }
    let(:mail) { UserMailer.account_activation(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Diver's logのアカウント認証用メールです")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@diving.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join).to include(user.name)
      expect(mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join).to include(user.activation_token)
      expect(mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join).to include(CGI.escape(user.email))
    end
  end

  describe "password_reset" do
    let(:user) { FactoryBot.create(:user) }
    let(:mail) { UserMailer.password_reset(user) }
    before do
      user.reset_token = User.new_token
    end

    it "renders the headers" do
      expect(mail.subject).to eq("Diver's logのパスワード再設定用メールです")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@diving.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join).to include(user.name)
      expect(mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join).to include(user.reset_token)
      expect(mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join).to include(CGI.escape(user.email))
    end
  end

end
