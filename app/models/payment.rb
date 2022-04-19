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

  counter_culture :phase,
                  column_name: 'payment_amount_cents',
                  delta_column: 'amount_cents'

  counter_culture :project,
                  column_name: 'payment_amount_cents',
                  delta_column: 'amount_cents'

  after_save ->(p) { PaymentStatusJob.perform_later(p.id) }
end
