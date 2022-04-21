class ProjectAccess < ApplicationRecord
  ROLES = %w[Client Accountant Contractor].freeze

  belongs_to :company
  belongs_to :user
  belongs_to :project

  has_rich_text :details
end
