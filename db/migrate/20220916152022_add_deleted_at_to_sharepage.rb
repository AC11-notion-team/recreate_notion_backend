class AddDeletedAtToSharepage < ActiveRecord::Migration[6.1]
  def change
    add_column :sharepages, :deleted_at, :datetime
    add_index :sharepages, :deleted_at
  end
end
