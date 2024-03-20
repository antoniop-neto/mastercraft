class ModifyBookings < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookings, :end_date_time, :datetime
    remove_column :bookings, :start_date_time, :datetime
    add_column :bookings, :start_hour, :integer
    add_column :bookings, :date, :date
  end
end
