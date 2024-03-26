class AddedPriceToServices < ActiveRecord::Migration[7.1]
  def change
    add_monetize :services, :price, currency: { present: false }
  end
end
