class PhaseMailer < ApplicationMailer
  def notify_update
    @phase = Phase.find params[:phase_id]

    # We need to figure out all the users impacted by this access right

    lead_email = @phase.assigned_to.email
    step_member_emails = @phase.steps.joins(:assigned_to).map { |s| s.assigned_to.email }
    step_member_emails << @phase.project.client.email if @phase.visible_to_client

    mail(to: lead_email,
         cc: step_member_emails.join(","),
         bcc: ENV['SUPPORT_EMAIL'],
         subject: "Project update: #{@phase.project.name} for #{@phase.project.client.full_name}")
  end
end
