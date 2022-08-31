class User < ApplicationRecord
  before_create :confirmation_token
# <<<<<<< HEAD
  # 加密
  require 'bcrypt'
  has_secure_password

  #驗證
# >>>>>>> feature/add_table
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true

  #關聯
  has_many :pages

  private
  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end