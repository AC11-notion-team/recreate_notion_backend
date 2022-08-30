class User < ApplicationRecord
  # 加密
  require 'bcrypt'
  has_secure_password
  #驗證
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :username, presence: true, uniqueness: true
  #關聯
  has_many :pages

end
