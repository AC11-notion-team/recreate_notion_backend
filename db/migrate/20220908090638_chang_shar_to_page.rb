class ChangSharToPage < ActiveRecord::Migration[6.1]
  def change
    remove_column :pages, :share, :integer
    add_column :pages, :share, :boolean
    change_column_default :pages, :share, false
  end
end
