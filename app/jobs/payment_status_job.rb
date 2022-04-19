class PaymentStatusJob < ApplicationJob
  queue_as :default

  def perform(payment_id)
    payment = Payment.find(payment_id)
    payment.phase.save
  end
end
