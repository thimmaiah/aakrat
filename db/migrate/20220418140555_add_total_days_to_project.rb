class AddTotalDaysToProject < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :total_days, :integer, default: 0
    add_column :projects, :completed_days, :integer, default: 0
    add_column :phases, :total_days, :integer, default: 0
    add_column :phases, :completed_days, :integer, default: 0
    add_column :steps, :days, :integer, default: 0
  end
end
