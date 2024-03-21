class CreateDayslots < ActiveRecord::Migration[7.1]
  def change
    create_table :dayslots do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :slots, array: true, default: []

      t.timestamps
    end
  end
end
