# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

require "rails_helper"

describe User do
  before do
    @attr = {
      name: "Example User",
      email: "user@example.com",
      password: "foobar",
      password_confirmation: "foobar"
    }
  end

  it "creates a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "requires a name" do
    no_name_user = User.new(@attr.merge(name: ""))
    expect(no_name_user).not_to be_valid
  end

  it "requires an email address" do
    no_email_user = User.new(@attr.merge(email: ""))
    expect(no_email_user).not_to be_valid
  end

  it "rejects names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(name: long_name))
    expect(long_name_user).not_to be_valid
  end

  it "accepts valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(email: address))
      expect(valid_email_user).to be_valid
    end
  end

  it "rejects invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(email: address))
      expect(invalid_email_user).not_to be_valid
    end
  end

  it "rejects duplicate email addresses" do
    # Put a user with given email address into the database.
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    expect(user_with_duplicate_email).not_to be_valid
  end

  it "rejects email addresses indentical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(email: upcased_email))
    user_with_duplicate_email = User.new(@attr)
    expect(user_with_duplicate_email).not_to be_valid
  end

  describe "password validations" do
    it "requires a password" do
      user = User.new(@attr.merge(password: "", password_confirmation: ""))
      expect(user).not_to be_valid
    end

    it "requires a matching password confirmation" do
      user = User.new(@attr.merge(password_confirmation: "invalid"))
      expect(user).not_to be_valid
    end

    it "rejects short passwords" do
      short = "a" * 5
      hash  = @attr.merge(password: short, password_confirmation: short)

      expect(User.new(hash)).not_to be_valid
    end

    it "rejects long passwords" do
      long = "a" * 41
      hash = @attr.merge(password: long, password_confirmation: long)

      expect(User.new(hash)).not_to be_valid
    end
  end

  describe "password encryption" do
    before do
      @user = User.create!(@attr)
    end

    it "has an encrypted password attribute" do
      expect(@user).to respond_to(:encrypted_password)
    end

    it "sets the encrypted password" do
      expect(@user.encrypted_password).not_to be_blank
    end

    describe "has_password? method" do
      it "is true if the passwords match" do
        expect(@user.has_password?(@attr[:password])).to be true
      end

      it "is false if the passwords don't match" do
        expect(@user.has_password?("invalid")).to be false
      end
    end

    describe "authenticate method" do
      it "returns nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        expect(wrong_password_user).to be_nil
      end

      it "returns nil for an email address with no user" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        expect(nonexistent_user).to be_nil
      end

      it "returns the user on email/password match" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        expect(matching_user).to eq @user
      end
    end
  end
end
