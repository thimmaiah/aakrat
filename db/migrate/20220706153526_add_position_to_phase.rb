class AddPositionToPhase < ActiveRecord::Migration[7.0]
  def change
    add_column :phases, :position, :integer
    add_column :steps, :position, :integer
    add_column :attachments, :position, :integer
  end
end
