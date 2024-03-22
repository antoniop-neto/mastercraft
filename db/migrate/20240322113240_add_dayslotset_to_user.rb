class AddDayslotsetToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :dayslot_set, :boolean, default: false
  end
end
