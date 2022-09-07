class User < ApplicationRecord
  before_create :confirmation_token
  
  # 加密
  require 'bcrypt'
  has_secure_password
  
  #驗證
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true

  #關聯
  has_many :pages
  #關聯, 一個人可以參與很多page的編輯 - 多對多(user - sharepage(第三方) - page )
  has_many :sharepages
  has_many :linkpages, :through => :sharepages, :source => :page

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  acts_as_paranoid

  private
  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
