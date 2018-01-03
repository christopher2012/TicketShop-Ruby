class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.integer :count
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
      t.integer :seat_number
      t.integer :price

      t.timestamps
    end
    add_index :tickets, [:user_id, :created_at]
  end
end
