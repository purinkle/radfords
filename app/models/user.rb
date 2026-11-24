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

require "digest"

class User < ApplicationRecord
  attribute :password, :string

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true,
                   length: { maximum: 50 }

  validates :email, presence: true,
                    format: { with: email_regex },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true,
                       confirmation: true,
                       length: { within: 6..40 }

  before_save :encrypt_password

  def password_matches?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    where(email: email).detect { |user| user.password_matches?(submitted_password) }
  end

  def self.authenticate_with_salt(id, cookie_salt)
    find_by(id: id, salt: cookie_salt)
  end

  private

  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end

  def encrypt(string)
    Digest::SHA2.hexdigest("#{salt}--#{string}")
  end

  def make_salt
    Digest::SHA2.hexdigest("#{Time.now.utc}--#{password}")
  end
end
