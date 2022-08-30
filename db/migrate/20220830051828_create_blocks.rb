class CreateBlocks < ActiveRecord::Migration[6.1]
  def change
    create_table :blocks do |t|
      t.belongs_to :page , type: :uuid
      t.belongs_to :user

      t.timestamps
    end
  end
end
