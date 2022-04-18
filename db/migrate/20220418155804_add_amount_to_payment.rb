class AddAmountToPayment < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :amount_cents, :decimal, precision: 20, scale: 2, default: "0.0"
    remove_column :payments, :amount
  end
end
