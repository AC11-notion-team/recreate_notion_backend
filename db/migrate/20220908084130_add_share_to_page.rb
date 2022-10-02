class AddShareToPage < ActiveRecord::Migration[6.1]
  def change
    add_column :pages, :share, :integer
    change_column_default :pages, :share, 0
  end
end
