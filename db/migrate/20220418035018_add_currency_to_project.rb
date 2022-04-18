class AddCurrencyToProject < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :currency, :string, limit: 5
  end
end
