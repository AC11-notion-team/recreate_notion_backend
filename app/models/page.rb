class Page < ApplicationRecord
  # 關聯
  has_many :blocks
  belongs_to :user

  #Linklist function
  def self.print_all_blocks(tail)
    block = Block.find_by("blockID": tail)
    blocks =[]
    blocks.unshift(block)
    prev_blockID = block[:prev_blockID]
    while prev_blockID != nil
      block = Block.find_by("blockID": prev_blockID)
      blocks.unshift(block)
      prev_blockID = block[:prev_blockID]
    end
    blocks
  end
  
end
