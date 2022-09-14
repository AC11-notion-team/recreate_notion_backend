class ChangIconDefaultToPages < ActiveRecord::Migration[6.1]
  def change
    change_column_default :pages, :icon, "🗒️"
  end
end
