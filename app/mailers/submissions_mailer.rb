class SubmissionsMailer < ApplicationMailer
  
  def admin_report_email(submission_id)
    @submission = Submission.find(submission_id)

    mail(to: ENV['ADMIN_REPORT_EMAIL'], subject: "[SAO-#{@submission.id}] Submission Report")
  end

  def pending_email(submission_id)
    @submission = Submission.find(submission_id)

    mail(
      from: 'Street Art Orlando Moderator <moderator@streetartorlando.com>',
      to: @submission.user.email,
      subject: 'Street Art Orlando Submission'
    )
  end

  def status_email(submission_id)
    @submission = Submission.find(submission_id)

    mail(
      from: 'Street Art Orlando Moderator <moderator@streetartorlando.com>',
      to: @submission.user.email,
      subject: 'Street Art Orlando Submission Update'
    )
    
    @submission.status_email_sent_at = DateTime.now
    @submission.save!
  end

end
