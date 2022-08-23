class CreateDatabases < ActiveRecord::Migration[6.1]
  def change
    create_table :databases do |t|
      t.string :object
      t.uuid :uuid
      t.json :created_by
      t.json :last_edited_by
      t.json :title
      t.text :description
      t.json :properties
      t.json :icon
      t.json :cover
      t.json :parent
      t.string :url
      t.boolean :archived
      t.boolean :is_inline

      t.timestamps
    end
  end
end
