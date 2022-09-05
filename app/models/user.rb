class User < ApplicationRecord

  #驗證
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  #關聯 一個人可以擁有很多page
  has_many :pages
  #關聯, 一個人可以參與很多page的編輯 - 多對多(user - sharepage(第三方) - page )
  has_many :sharepages
  has_many :linkpages, :through => :sharepages, :source => :page

end


