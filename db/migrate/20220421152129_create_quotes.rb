class CreateQuotes < ActiveRecord::Migration[7.0]
  def change
    create_table :quotes do |t|
      t.references :company, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.string :project_type, limit: 30
      t.string :scale, limit: 20
      t.string :style, limit: 30
      t.string :pattern, limit: 30
      t.text :services

      t.timestamps
    end
  end
end
