class ChangeColumnPage < ActiveRecord::Migration[6.1]
  def change
    rename_column :blocks, :pages_id , :page_id
  end
end
