class Step < ApplicationRecord
  belongs_to :project
  belongs_to :company
  belongs_to :phase
  belongs_to :assigned_to, class_name: "User"

  has_many :notes, as: :owner, dependent: :destroy
  has_rich_text :details
  has_many_attached :attachments, service: :amazon, dependent: :destroy

  validates :name, :start_date, :end_date, :days, presence: true

  before_validation :set_end_date

  counter_culture :phase,
                  column_name: proc { |s| s.completed ? 'completed_days' : nil },
                  delta_column: 'days'

  counter_culture :phase,
                  column_name: 'total_days',
                  delta_column: 'days'

  counter_culture :project,
                  column_name: proc { |s| s.completed ? 'completed_days' : nil },
                  delta_column: 'days'

  counter_culture :project,
                  column_name: 'total_days',
                  delta_column: 'days'

  after_update ->(_s) { StepMailer.with(step_id: id).notify_update.deliver_later if project.status == "In Progress" }

  def set_end_date
    self.end_date ||= start_date + days.days
    self.days = (self.end_date - start_date).to_i if days.zero?
  end

  def delayed?
    Time.zone.today > end_date && !completed
  end

  def on_time_status
    if completed
      "Complete"
    else
      Time.zone.today < end_date ? "On-Time" : "Delayed"
    end
  end
end
