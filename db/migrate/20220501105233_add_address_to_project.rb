class AddAddressToProject < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :address, :text
    add_column :clients, :address, :text
  end
end
