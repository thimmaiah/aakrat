class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.integer :owner_id
      t.string :owner_type, limit: 30

      t.timestamps
    end
  end
end
