class AddTailToPage < ActiveRecord::Migration[6.1]
  def change
    add_column :pages, :tail, :string
  end
end
