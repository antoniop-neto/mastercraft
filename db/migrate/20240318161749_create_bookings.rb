class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.timestamp :start_date_time
      t.timestamp :end_date_time

      t.timestamps
    end
  end
end
