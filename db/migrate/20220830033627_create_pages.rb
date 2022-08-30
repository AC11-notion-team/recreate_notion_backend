class CreatePages < ActiveRecord::Migration[6.1]
  def change
    create_table :pages, id: :uuid do |t|
      t.string :icon
      t.string :cover
      t.string :url

      t.timestamps
    end
  end
end
