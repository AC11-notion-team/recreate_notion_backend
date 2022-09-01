class Page < ApplicationRecord
  # 關聯
  has_many :blocks
  belongs_to :user

  #Linklist function
  def self.print_all_blocks(tail)
    block = Block.find_by("editorID": tail)
    blocks =[]
    blocks.unshift(block)
    prev_editorID = block[:prev_editorID]
    while prev_editorID != nil
      block = Block.find_by("editorID": prev_editorID)
      blocks.unshift(block)
      prev_editorID = block[:prev_editorID]
    end
    blocks
  end
  
end
