require 'securerandom'

class User < ApplicationRecord
  before_save { email.downcase! }
  before_validation { self.api_key = SecureRandom.uuid }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates_presence_of :password, require: true, length: { minimum: 6 }
  validates :api_key, uniqueness: true, presence: true

  has_secure_password
end
