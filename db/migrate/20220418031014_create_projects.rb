class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.decimal :cost_estimate_cents
      t.integer :percentage_completed
      t.string :status, limit: 20
      t.references :company, null: false, foreign_key: true
      t.references :client, foreign_key: {to_table: :users}
      t.references :team_lead, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
