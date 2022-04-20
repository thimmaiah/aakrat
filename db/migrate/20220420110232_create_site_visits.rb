class CreateSiteVisits < ActiveRecord::Migration[7.0]
  def change
    create_table :site_visits do |t|
      t.references :project, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.references :phase, null: false, foreign_key: true
      t.decimal :cost_cents, precision: 20, scale: 2, default: "0.0"
      t.date :scheduled_on
      t.date :conducted_on
      t.references :assigned_to, null: false, foreign_key: {to_table: :users}
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
