class AddClosedAtToTicket < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :closed_at, :timestamp
  end
end
