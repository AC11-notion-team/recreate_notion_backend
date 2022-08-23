class CreateBlocks < ActiveRecord::Migration[6.1]
  def change
    create_table :blocks do |t|
      t.string :object
      t.uuid :uuid
      t.json :parent
      t.string :type
      t.json :created_by
      t.json :last_edited_by
      t.boolean :archived
      t.boolean :has_children
      t.json :type_specific_info

      t.timestamps
    end
  end
end
