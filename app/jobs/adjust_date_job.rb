class AdjustDateJob < ApplicationJob
  queue_as :default

  # def perform(id, class_name)
  #   case class_name
  #   when "Phase"
  #     phase = Phase.find(id)
  #   when "Step"
  #     step = Step.find(id)
  #     adjust(step)
  #   end
  # end

  # def adjust(step)
  #   steps = step.phase.steps.where("start_date > ?", step.start_date).order(start_date: :asc)
  #   steps.each do |adjust_step|
  #   end
  # end
end
