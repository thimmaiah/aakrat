module PhasesHelper
  def phase_payment_status_badge(phase)
    case phase.payment_status
    when "Paid"
      "bg-success"
    when "Partial", "Not Paid"
      phase.completed ? "bg-danger" : "bg-warning"
    when "N/A"
      "bg-info"
    else
      "bg-warning"
    end
  end
end
