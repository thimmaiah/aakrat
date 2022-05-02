class AddVisibleToAttachment < ActiveRecord::Migration[7.0]
  def change
    add_column :attachments, :visible_to_client, :boolean, default: false
  end
end
