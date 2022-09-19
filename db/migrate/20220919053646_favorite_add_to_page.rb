class FavoriteAddToPage < ActiveRecord::Migration[6.1]
  def change
    add_column :pages, :favorite, :boolean, default: false
  end
end
