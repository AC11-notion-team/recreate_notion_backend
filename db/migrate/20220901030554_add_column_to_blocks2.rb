class AddColumnToBlocks2 < ActiveRecord::Migration[6.1]
  def change
    add_column :blocks, :prev_editorID, :string
  end
end
