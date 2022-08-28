class User < ApplicationRecord
  require 'bcrypt'
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :username, presence: true, uniqueness: true

end
