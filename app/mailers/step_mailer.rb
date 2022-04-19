class StepMailer < ApplicationMailer
  def notify_update
    @step = Step.find params[:step_id]

    # We need to figure out all the users impacted by this access right

    step_member_emails = [@step.assigned_to.email]
    lead_email = @step.phase.assigned_to.email
    step_member_emails << @step.project.client.email if @step.visible_to_client

    mail(to: lead_email,
         cc: step_member_emails.join(","),
         bcc: ENV['SUPPORT_EMAIL'],
         subject: "Project update: #{@step.project.name} for #{@step.project.client.full_name}")
  end
end
