class AddColumnToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :vertify_status, :boolean
  end
end
