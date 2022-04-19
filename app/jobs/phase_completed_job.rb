class PhaseCompletedJob < ApplicationJob
  queue_as :default

  def perform(phase_id)
    phase = Phase.find(phase_id)
    phase.save if phase.total_days == phase.completed_days
  end
end
