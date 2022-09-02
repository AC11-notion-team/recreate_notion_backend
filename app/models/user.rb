
class User < ApplicationRecord

  #驗證
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  #關聯
  has_many :pages

end


