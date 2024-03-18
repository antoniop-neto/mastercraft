class CreateServices < ActiveRecord::Migration[7.1]
  def change
    create_table :services do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :price
      t.string :name
      t.string :address
      t.timestamp :start_time
      t.timestamp :end_time

      t.timestamps
    end
  end
end
