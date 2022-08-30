class DropTableHeaders < ActiveRecord::Migration[6.1]
  def change
    drop_table :headers
  end
end
