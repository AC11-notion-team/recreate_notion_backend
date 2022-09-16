class AdjustPageShareEditable < ActiveRecord::Migration[6.1]
  def change
    remove_column :pages, :share
    remove_column :pages, :editable
    add_column :pages, :editable, :boolean
  end
end
