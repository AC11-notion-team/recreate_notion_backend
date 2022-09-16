class AddDeletedAtToPages < ActiveRecord::Migration[6.1]
  def change
    add_column :pages, :deleted_at, :datetime, if_not_exists: true
    add_index :pages, :deleted_at, if_not_exists: true
  end
end
