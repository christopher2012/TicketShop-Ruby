class AddColumnDeletedToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :deleted, :boolean, default: false
  end
end
