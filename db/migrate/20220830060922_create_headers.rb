class CreateHeaders < ActiveRecord::Migration[6.1]
  def change
    create_table :headers do |t|
      t.belongs_to

      t.timestamps
    end
  end
end
