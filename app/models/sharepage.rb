class Sharepage < ApplicationRecord
  acts_as_paranoid
  belongs_to :page
  belongs_to :user
end
