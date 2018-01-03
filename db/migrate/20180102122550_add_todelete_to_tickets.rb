class AddTodeleteToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :to_delete, :boolean, default: false
  end
end
