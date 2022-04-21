class Quote < ApplicationRecord
  belongs_to :company
  belongs_to :user
  belongs_to :client

  has_rich_text :details
  has_many_attached :attachments, service: :amazon, dependent: :destroy

  serialize :services
end
