class Phase < ApplicationRecord
  belongs_to :company
  belongs_to :project
  belongs_to :assigned_to, class_name: "User"
  has_many :notes, as: :owner, dependent: :destroy
  has_many :steps, dependent: :destroy

  has_rich_text :details

  def delayed?
    Time.zone.today > end_date
  end

  def on_time_status
    unless completed
      Time.zone.today < end_date ? "On-Time" : "Delayed"
    end
  end
end
