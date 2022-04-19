class AddStatusToPayment < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :status, :string, limit: 50
    add_column :payments, :due_date, :date
    add_column :payments, :received_on, :date
  end
end
