require 'rails_helper'

RSpec.describe User, type: :model do
  
  let(:user) { User.new(
    name: "Example User",
    email: "hoge@example.com",
    password: "foobar",
    password_confirmation: "foobar"
  ) }

  describe "User" do
    it "should be valid" do
      expect(user).to be_valid
    end
  end

  describe "name" do
    it "gives presece" do
      user.name = "  "
      expect(user).to be_invalid
    end

    context "50 characters" do
      it "is not too long"do
        user.name = "a" * 50
        expect(user).to be_valid
      end
    end

    context "51 characters" do
      it "is too long" do
        user.name = "a" * 51
        expect(user).to be_invalid
      end
    end
  end

  describe "email" do
    it "gives presence" do
      user.email = "  "
      expect(user).to be_invalid
    end
    
    context "254 characters" do
      it "is not too long" do
        user.email = "a" * 243 + "@example.com"
        expect(user).to be_valid
      end
    end

    context "255 characters" do
      it "is too long" do
        user.email = "a" * 244 + "@example.com"
        expect(user).to be_invalid
      end
    end

    it "should accept valid addresses" do
      valid_addresses = %w[hoge@example.com FOO@bar.COM HO-G_E@baz.bar.org ein.zwei@drei.jp one+two@three.en]
      valid_addresses.each do |valid_address|
      user.email = valid_address
      expect(user).to be_valid
      end
    end

    it "should reject invalid addresses" do
      invalid_addresses = %w[hoge@example,com FOO_bar.COM hoge@bar. one@two_three.en foo@bar..org]
      invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      expect(user).to be_invalid
      end
    end

    it "should be unique" do
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      user.save!
      expect(duplicate_user).to be_invalid
    end

    it "should be saved as lower-case" do
      user.email = "Foo@ExAMPle.CoM"
      user.save!
      expect(user.reload.email).to eq 'foo@example.com'
    end
  end

  describe "password and password_confirmation" do
    it "should be present (nonblank)" do
      user.password = user.password_confirmation = " " * 6
      expect(user).to be_invalid
    end

    context "5 characters" do
      it "is too short" do
        user.password = user.password_confirmation = "a" * 5
        expect(user).to be_invalid
      end
    end

    context "6 characters" do
      it "is not too short" do
        user.password = user.password_confirmation = "a" * 6
        expect(user).to be_valid
      end
    end
  end

  it 'authenticated? returns flase for a user with nil digest' do
    expect(user.authenticated?(:remember ,'')).to be_falsey
  end
end
