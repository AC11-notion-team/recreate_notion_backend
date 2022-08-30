class DropCreatebies < ActiveRecord::Migration[6.1]
  def change
    drop_table :create_bies
  end
end
