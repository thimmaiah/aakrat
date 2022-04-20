class AddApprovalToStep < ActiveRecord::Migration[7.0]
  def change
    remove_column :steps, :approved
    add_column :steps, :approval_status, :string, limit: 10, default: "N/A"
  end
end
