class CreateSharepages < ActiveRecord::Migration[6.1]
  def change
    create_table :sharepages do |t|
      t.belongs_to :page, null: false, foreign_key: true, type: :uuid
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
