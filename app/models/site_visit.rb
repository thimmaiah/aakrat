class SiteVisit < ApplicationRecord
  # Make all models searchable
  ThinkingSphinx::Callbacks.append(self, behaviours: [:real_time])

  belongs_to :project
  belongs_to :company
  belongs_to :phase
  belongs_to :assigned_to, class_name: "User"

  has_rich_text :details
  has_many_attached :attachments, service: :amazon, dependent: :destroy

  monetize :cost_cents, with_currency: ->(i) { i.project.currency }

  validates :scheduled_on, :cost, presence: true
  validates :cost, numericality: { greater_than: 0 }

  before_save :set_conducted_on
  def set_conducted_on
    self.conducted_on ||= Time.zone.today if completed_changed? && completed
  end
end
