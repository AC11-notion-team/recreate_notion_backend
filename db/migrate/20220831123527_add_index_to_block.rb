class AddIndexToBlock < ActiveRecord::Migration[6.1]
  def change
    add_index(:blocks , :editorID)
  end
end
