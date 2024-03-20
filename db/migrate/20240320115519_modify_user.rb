class ModifyUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :start_hour, :integer
    add_column :users, :end_hour, :integer
  end
end
