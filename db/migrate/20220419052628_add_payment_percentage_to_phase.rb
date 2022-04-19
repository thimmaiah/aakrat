class AddPaymentPercentageToPhase < ActiveRecord::Migration[7.0]
  def change
    add_column :phases, :payment_due_percentage, :integer, default: 0
    add_column :phases, :payment_due_cents, :decimal, precision: 20, scale: 2, default: "0.0"
  end
end
