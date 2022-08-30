class DropTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :blocks
    drop_table :pages
    drop_table :databases
    drop_table :create_bies 
  end
end
