class AddFeeTypeToProject < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :fee_type, :string, limit: 20
    add_column :projects,  :project_type, :string, limit: 30
    add_column :projects,  :scale,:string, limit: 20
    add_column :projects,  :style, :string,limit: 30
    add_column :projects,  :pattern, :string,limit: 30
    add_column :projects,  :services, :text

  end
end
