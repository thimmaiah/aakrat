class CloneProjectJob < ApplicationJob
  queue_as :default

  def perform(from_project_id, to_project_id, include_steps: true)
    from_project = Project.find(from_project_id)
    to_project = Project.find(to_project_id)

    from_project.phases.order(start_date: :asc).each do |from_phase|
      # Compute the days to start of phase
      start_days = (from_phase.start_date - from_project.start_date).to_i

      # Compute days in the phase
      phase_days = (from_phase.end_date - from_phase.start_date).to_i

      # Create the clone
      to_phase = from_phase.dup
      to_phase.project    = to_project
      to_phase.start_date = to_project.start_date + start_days.days
      to_phase.end_date   = to_phase.start_date + phase_days.days
      to_phase.save!

      clone_steps(to_project, from_phase, to_phase) if include_steps
    end
  end

  def clone_steps(to_project, from_phase, to_phase)
    from_phase.steps.order(start_date: :asc).each do |from_step|
      # Compute the days to start of phase
      start_days = (from_step.start_date - from_phase.start_date).to_i

      # Compute days in the phase
      step_days = (from_step.end_date - from_step.start_date).to_i

      # Create the clone
      to_step = from_step.dup
      to_step.project     = to_project
      to_step.phase       = to_phase
      to_step.start_date  = to_phase.start_date + start_days.days
      to_step.end_date    = to_step.start_date + step_days.days
      to_step.save!
    end
  end
end
