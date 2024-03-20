class AddToDayslots < ActiveRecord::Migration[7.1]
  def change
    add_column :dayslots, :date, :date
  end
end
