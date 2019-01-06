class ReportsMailer < ApplicationMailer
  
  def admin_report_email(report_id)
    @report = Report.find(report_id)

    mail(to: ENV['ADMIN_REPORT_EMAIL'], subject: "[SAO-#{@report.id}] Reported")
  end

end
