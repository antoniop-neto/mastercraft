class AddDatesToService < ActiveRecord::Migration[7.1]
  def change
    add_column :services, :start_date, :date
    add_column :services, :end_date, :date
  end
end
