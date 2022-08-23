class CreatePages < ActiveRecord::Migration[6.1]
  def change
    create_table :pages do |t|
      t.string :object
      t.uuid :uuid
      t.json :created_by
      t.json :last_edited_by
      t.boolean :archived
      t.json :icon
      t.json :cover
      t.json :properties
      t.json :parent
      t.string :url

      t.timestamps
    end
  end
end
