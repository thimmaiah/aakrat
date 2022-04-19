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

  def phase_completion_badge(phase)
    if phase.percentage_completed_days < 50
      "bg-warning"
    elsif phase.percentage_completed_days >= 50 && phase.percentage_completed_days < 100
      "bg-info"
    else
      "bg-success"
    end
  end

end
