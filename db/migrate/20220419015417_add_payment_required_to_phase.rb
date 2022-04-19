class AddPaymentRequiredToPhase < ActiveRecord::Migration[7.0]
  def change
    add_column :phases, :payment_required, :boolean, default: false
  end
end
