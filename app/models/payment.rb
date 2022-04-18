# == Schema Information
#
# Table name: payments
#
#  id               :integer          not null, primary key
#  company_id        :integer          not null
#  amount           :decimal(10, 2)   default("0.00"), not null
#  plan             :string(30)
#  discount         :decimal(10, 2)   default("0.00")
#  reference_number :string(255)
#  user_id          :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  deleted_at       :datetime
#

class Payment < ApplicationRecord
  include Trackable

  belongs_to :company
  belongs_to :user
  belongs_to :phase
  belongs_to :project

  has_rich_text :details
  has_many_attached :attachments, service: :amazon, dependent: :destroy

  validates :amount_cents, presence: true
  monetize :amount_cents, with_currency: ->(i) { i.project.currency }
end
