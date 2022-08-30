class AddColumnToPage < ActiveRecord::Migration[6.1]
  def change
    add_column :pages, :user_id , :integer
  end
end
