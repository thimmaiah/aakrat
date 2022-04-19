class Phase < ApplicationRecord
  belongs_to :company
  belongs_to :project
  belongs_to :assigned_to, class_name: "User"

  has_many :notes, as: :owner, dependent: :destroy

  has_many :steps, dependent: :destroy
  has_many :payments, dependent: :destroy

  has_rich_text :details
  monetize :payment_amount_cents, with_currency: ->(i) { i.project.currency }
  monetize :payment_due_cents, with_currency: ->(i) { i.project.currency }

  validates :name, :start_date, :end_date, :days, presence: true

  before_validation :set_end_date
  before_save :set_payment_status

  STATUS = ["Not Started", "In Progress", "Client Review", "Completed", "Halted"].freeze

  def set_end_date
    self.end_date ||= start_date + days.days
    self.days = (self.end_date - start_date).to_i if days.zero?
  end

  def set_payment_status
    if payment_required
      self.payment_due_cents = payment_due_percentage * project.cost_estimate_cents / 100.0
      self.payment_status = if payment_amount_cents.zero?
                              completed ? "Payment Pending" : "Not Paid"
                            else
                              "Paid #{payment_amount}"
                            end
    else
      self.payment_status ||= "N/A"
    end
  end

  after_update ->(_p) { PhaseMailer.with(phase_id: id).notify_update.deliver_later }

  def delayed?
    Time.zone.today >= end_date && !completed
  end

  def on_time_status
    if completed
      "Complete"
    else
      Time.zone.today < end_date ? "On-Time" : "Delayed"
    end
  end

  def percentage_completed_days
    total_days.positive? ? completed_days * 100.0 / total_days : 0
  end
end
