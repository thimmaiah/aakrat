class AddEntityToProject < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :entity_name, :string, limit: 100
    add_column :companies, :entity_names, :text
  end
end
