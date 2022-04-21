class ProjectAccess < ApplicationRecord
  ROLES = %w[Client Accountant Contractor].freeze

  belongs_to :company
  belongs_to :user
  belongs_to :project

  has_rich_text :details

  after_destroy :delete_role
  after_save :set_role
  def set_role
    user.add_role role_name.downcase.to_sym, project
  end

  def delete_role
    user.remove_role role_name.downcase.to_sym, project
  end
end
