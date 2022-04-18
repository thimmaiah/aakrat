class Step < ApplicationRecord
  belongs_to :project
  belongs_to :company
  belongs_to :phase
  belongs_to :assigned_to, class_name: "User"

  has_many :notes, as: :owner, dependent: :destroy
  has_rich_text :details
  has_many_attached :attachments, service: :amazon, dependent: :destroy

  def delayed?
    Time.zone.today > end_date
  end

  def on_time_status
    unless completed
      Time.zone.today < end_date ? "On-Time" : "Delayed"
    end
  end
end
