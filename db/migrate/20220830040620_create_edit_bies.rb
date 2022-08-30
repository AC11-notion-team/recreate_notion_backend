class CreateEditBies < ActiveRecord::Migration[6.1]
  def change
    create_table :edit_bies do |t|
      t.references :pages , type: :uuid
      t.references :users
      
      t.timestamps
    end
  end
end
