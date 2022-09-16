class AddDefaultToPageTitle < ActiveRecord::Migration[6.1]
  def change
    change_column_default :pages, :title, "Untitled"
  end
end
