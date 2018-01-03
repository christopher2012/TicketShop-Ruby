class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.date :date_event
      t.string :name
      t.text :description
      t.integer :min_age
      t.integer :seats
      t.integer :price

      t.timestamps
    end
  end
end
