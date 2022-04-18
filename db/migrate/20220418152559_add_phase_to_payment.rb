class AddPhaseToPayment < ActiveRecord::Migration[7.0]
  def change
    add_reference :payments, :phase, null: false, foreign_key: true
  end
end
