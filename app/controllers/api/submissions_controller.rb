class Api::SubmissionsController < Api::BaseController

  # GET /submissions
  def index
    page = params[:page] || 1

    submissions = Submission.page(page)
    render json: submissions
  end

  # POST /submissions
  def create
    submission = Submission.new
    submission.title = params[:title]
    submission.photo = params[:photo]
    submission.user = current_user

    if submission.save
      render json: submission, status: :created
    else
      render json: submission.errors, status: :unprocessable_entity
    end
  end
    
end