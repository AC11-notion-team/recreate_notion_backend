class Page < ApplicationRecord
  acts_as_paranoid
  attr_accessor :shareuser

  # 關聯
  has_many :blocks
  # 關聯 - 多對多(user - sharepage(第三方) - page )
  has_many :sharepages, dependent: :destroy
  has_many :users, through: :sharepages

  # Linklist function
  def self.print_all_blocks(tail)
    block = Block.find_by("blockID": tail)
    blocks = []

    return blocks if block.nil? || block.nil?

    blocks.unshift(block)
    prev_blockID = block[:prev_blockID]
    until prev_blockID.nil?
      block = Block.find_by("blockID": prev_blockID)
      blocks.unshift(block)
      prev_blockID = block[:prev_blockID]
    end

    blocks
  end
end
