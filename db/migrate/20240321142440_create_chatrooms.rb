class CreateChatrooms < ActiveRecord::Migration[7.1]
  def change
    create_table :chatrooms do |t|
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
