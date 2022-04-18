class Phase < ApplicationRecord
  belongs_to :company
  belongs_to :project
  belongs_to :assigned_to, class_name: "User"
  has_many :notes, as: :owner, dependent: :destroy
  has_many :steps, dependent: :destroy

  has_rich_text :details
end
