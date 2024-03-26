class AddFieldsToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :state, :string
    add_column :bookings, :service_sku, :string
    add_column :bookings, :amount_cents, :integer
    add_column :bookings, :checkout_session_id, :string
  end
end
