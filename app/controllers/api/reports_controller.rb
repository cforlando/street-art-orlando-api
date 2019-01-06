class Api::ReportsController < Api::BaseController
  skip_before_action :authenticate_request, only: [:create]

  # POST /reports
  def create
    submission = Submission.find_by(id: params[:submission_id])
    user = User.find_by(id: params[:user_id])

    report = Report.new
    report.submission = submission
    report.user = user if user.present?
    report.ip_address = params[:ip_address]
    report.device_identifier = params[:device_identifier]

    if report.save
      ReportsMailer.admin_report_email(report.id).deliver_later
      render json: { success: true }, status: :accepted
    else
      render json: { errors: report.errors.full_messages }, status: :unprocessable_entity
    end
  end

end