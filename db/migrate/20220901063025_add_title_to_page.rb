class AddTitleToPage < ActiveRecord::Migration[6.1]
  def change
    add_column :pages, :title, :string
  end
end
