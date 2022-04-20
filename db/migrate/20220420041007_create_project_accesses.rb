class CreateProjectAccesses < ActiveRecord::Migration[7.0]
  def change
    create_table :project_accesses do |t|
      t.references :company, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.string :role_name, limit: 20

      t.timestamps
    end
  end
end
