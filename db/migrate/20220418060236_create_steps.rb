class CreateSteps < ActiveRecord::Migration[7.0]
  def change
    create_table :steps do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.string :status, limit: 20
      t.references :project, null: false, foreign_key: true
      t.references :phase, null: false, foreign_key: true
      t.references :assigned_to, null: false, foreign_key: {to_table: :users}
      t.boolean :visible_to_client, default: false
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
