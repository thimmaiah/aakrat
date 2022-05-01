class AddDiscountToProject < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :discount, :decimal, precision: 5, scale: 2, default: 0
  end
end
