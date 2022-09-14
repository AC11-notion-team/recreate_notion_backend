class Block < ApplicationRecord
  acts_as_paranoid
  # 關聯
  belongs_to :page
end
