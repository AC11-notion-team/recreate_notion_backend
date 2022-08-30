class CreateCreateBies < ActiveRecord::Migration[6.1]
  def change
    create_table :create_bies do |t|
      t.references :pages , type: :uuid
      t.references :users
      
      t.timestamps
    end
  end
end
