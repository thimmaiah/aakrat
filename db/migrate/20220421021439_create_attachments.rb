class CreateAttachments < ActiveRecord::Migration[7.0]
  def change
    create_table :attachments do |t|
      t.string :name
      t.references :attached_by, null: false, foreign_key: {to_table: :users}
      t.string :approval_status, limit: 10
      t.references :approved_by, null: false, foreign_key: {to_table: :users}
      t.references :company, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.references :phase, null: false, foreign_key: true
      t.references :step, null: false, foreign_key: true

      t.timestamps
    end
  end
end
