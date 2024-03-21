class DeleteFromServices < ActiveRecord::Migration[7.1]
  def change
    remove_column :services, :start_time, :datetime
    remove_column :services, :end_time, :datetime
  end
end
