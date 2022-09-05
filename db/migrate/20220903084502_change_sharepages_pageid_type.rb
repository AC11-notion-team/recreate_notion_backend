class ChangeSharepagesPageidType < ActiveRecord::Migration[6.1]
  def change
    remove_column :sharepages, :page_id
    add_column :sharepages, :page_id, :uuid
  end
end
