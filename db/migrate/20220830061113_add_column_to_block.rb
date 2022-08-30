class AddColumnToBlock < ActiveRecord::Migration[6.1]
  def change
    add_column :blocks, :type, :string
    add_column :blocks, :data, :json
  end
end
