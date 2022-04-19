class Phase < ApplicationRecord
  belongs_to :company
  belongs_to :project
  belongs_to :assigned_to, class_name: "User"

  has_many :notes, as: :owner, dependent: :destroy

  has_many :steps, dependent: :destroy
  has_many :payments, dependent: :destroy

  has_rich_text :details
  monetize :payment_amount_cents, with_currency: ->(i) { i.project.currency }

  validates :start_date, :end_date, :name, presence: true

  before_save :set_payment_status

  def set_payment_status
    if payment_required
      self.payment_status = if payment_amount_cents.zero?
                              completed ? "Payment Pending" : "Not Paid"
                            else
                              "Paid #{payment_amount}"
                            end
    else
      self.payment_status ||= "N/A"
    end
  end

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
    completed_days * 100.0 / total_days
  end
end
