module PaymentsHelper
  def payment_status_badge(payment)
    case payment.status
    when "Confirmed"
      "bg-success"
    when "Halted", "Overdue", "Defaulted"
      "bg-danger"
    when "Received"
      "bg-info"
    else
      "bg-warning"
    end
  end
end
