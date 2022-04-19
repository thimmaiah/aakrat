class AddClonedFromToProject < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :cloned_from, :integer
  end
end
