class AddBudgetToProject < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :client_estimated_budget_cents, :decimal, precision: 20, scale: 2, default: "0.0"
    add_column :projects, :actual_cost_cents, :decimal, precision: 20, scale: 2, default: "0.0"
    add_column :projects, :estimated_builtup_area, :integer, default: 0
    add_column :projects, :actual_builtup_area, :integer, default: 0
    add_column :projects, :fees_cents, :decimal, precision: 20, scale: 2, default: "0.0"
    add_column :projects, :percentage_of_estimated_budget, :decimal, precision: 5, scale: 2, default: "0.0"
    add_column :projects, :per_sq_ft_rate_cents, :decimal, precision: 10, scale: 2, default: "0.0"
    add_column :steps, :approved, :boolean, default: false
  end
end
