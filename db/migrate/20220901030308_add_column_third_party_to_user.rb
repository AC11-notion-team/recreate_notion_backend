class AddColumnThirdPartyToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :third_party, :boolean
  end
end
