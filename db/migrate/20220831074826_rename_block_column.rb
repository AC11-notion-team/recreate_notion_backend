class RenameBlockColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :blocks, :type, :kind
    add_column    :blocks, :editorID, :string
  end
end
