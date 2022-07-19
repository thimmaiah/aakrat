class AddPermissionToProjectAccess < ActiveRecord::Migration[7.0]
  def change
    add_column :project_accesses, :permissions, :integer
  end
end
