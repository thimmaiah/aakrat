class AddDaysToPhase < ActiveRecord::Migration[7.0]
  def change
    add_column :phases, :days, :integer, default: 0
    add_column :steps, :days, :integer, default: 0
  end
end
