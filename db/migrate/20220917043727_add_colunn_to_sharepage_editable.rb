class AddColunnToSharepageEditable < ActiveRecord::Migration[6.1]
  def change
    add_column :sharepages, :editable, :boolean
  end
end
