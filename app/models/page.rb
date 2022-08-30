class Page < ApplicationRecord
  # 關聯
  has_many :blocks
  belongs_to :user
  
end
