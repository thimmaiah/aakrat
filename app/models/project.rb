class Project < ApplicationRecord
  belongs_to :company
  belongs_to :client, class_name: "User"
  belongs_to :team_lead, class_name: "User"

  has_many :phases, dependent: :destroy
  has_many :payments, dependent: :destroy

  has_many :notes, as: :owner, dependent: :destroy
  has_rich_text :details

  STATUS = ["Not Started", "In Progress", "Completed", "Halted", "Abandoned"].freeze
  PAYMENT_STATUS = ["Not Paid", "Partial Payment", "Paid"].freeze

  monetize :cost_estimate_cents, with_model_currency: :currency

  def percentage_completed_days
    completed_days * 100.0 / total_days
  end
end
