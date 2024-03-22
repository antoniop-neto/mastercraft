class DeleteAddDates < ActiveRecord::Migration[7.1]
  def change
    remove_column :services, :start_date, :date
    remove_column :services, :end_date, :date

    add_column :users, :start_date, :date
    add_column :users, :end_date, :date
  end
end
