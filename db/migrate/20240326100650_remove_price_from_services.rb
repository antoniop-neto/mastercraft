class RemovePriceFromServices < ActiveRecord::Migration[7.1]
  def change
    remove_column :services, :price, :integer
  end
end
