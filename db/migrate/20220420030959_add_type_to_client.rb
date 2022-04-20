class AddTypeToClient < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :user_type, :string, limit: 15
  end
end
