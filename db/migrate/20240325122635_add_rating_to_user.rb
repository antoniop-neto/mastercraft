class AddRatingToUser < ActiveRecord::Migration[7.1]
  def change
      add_column :users, :rating, :float
  end
end
