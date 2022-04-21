class ProjectAccess < ApplicationRecord
  ROLES = %w[Client Accountant Contractor].freeze

  belongs_to :company
  belongs_to :user
  belongs_to :project

  has_rich_text :details

  scope :for, ->(user, roles) { where("project_accesses.user_id=? and project_accesses.role_name in (?)", user.id, roles) }
end
