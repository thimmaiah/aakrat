class AddPaymentAmountToPhase < ActiveRecord::Migration[7.0]
  def change
    add_column :phases, :payment_amount_cents, :decimal, precision: 20, scale: 2, default: "0.0"
    add_column :projects, :payment_amount_cents, :decimal, precision: 20, scale: 2, default: "0.0"
  end
end
