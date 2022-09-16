class RenameBlockEditorId < ActiveRecord::Migration[6.1]
  def change
    rename_column :blocks, :editorID, :blockID
    rename_column :blocks, :prev_editorID, :prev_blockID
  end
end
