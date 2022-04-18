class Project < ApplicationRecord
  belongs_to :company
  belongs_to :client, class_name: "User"
  belongs_to :team_lead, class_name: "User"

  STATUS = ["Started", "In Progress", "Completed", "Halted", "Abandoned"].freeze

  monetize :cost_estimate_cents, with_model_currency: :currency
end
