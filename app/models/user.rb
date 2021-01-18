class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true
  validates :api_key, uniqueness: true, presence: true

  has_secure_password
end
