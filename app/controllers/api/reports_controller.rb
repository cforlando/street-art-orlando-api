class Api::ReportsController < Api::BaseController
  skip_before_action :authenticate_request, only: [:create, :codes]

  REPORT_CODES = [
    { code: 0, text: "Uploaded by mistake" },
    { code: 1, text: "Sexually explicit" },
    { code: 2, text: "Violent imagery" },
    { code: 3, text: "Spam or scam" },
    { code: 4, text: "Doesn't belong on Street Art Orlando" },
    { code: 5, text: "Offensive content" }
  ].freeze

  # POST /reports
  def create
    submission = Submission.find_by(id: params[:submission_id])
    user = User.find_by(id: params[:user_id])
    reason = REPORT_CODES.select { |row| row[:code].to_s == params[:code] }
    reason = reason.first[:text] if reason.present?

    report = Report.new
    report.submission = submission
    report.user = user if user.present?
    report.reason = reason
    report.ip_address = request.remote_ip
    report.device_identifier = device_identifier

    if report.save
      ReportsMailer.admin_report_email(report.id).deliver_later
      render json: { success: true }, status: :accepted
    else
      render json: { errors: report.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def codes
    render json: { codes: REPORT_CODES }
  end

end