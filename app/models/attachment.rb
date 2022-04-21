class Attachment < ApplicationRecord
  belongs_to :attached_by, class_name: "User"
  belongs_to :approved_by, class_name: "User", optional: true
  belongs_to :company
  belongs_to :project
  belongs_to :phase
  belongs_to :step

  has_rich_text :details
  has_many_attached :attachments, service: :amazon, dependent: :destroy

  validates :name, presence: true

  scope :visible_to_client, -> { where(approval_status: "Approved") }
end
