class Api::SubmissionsController < Api::BaseController
  skip_before_action :authenticate_request, only: [:index]

  PROCESSING = 'processing'

  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 10

  # GET /submissions
  def index
    page = params[:page] || DEFAULT_PAGE
    per_page = params[:per_page] || DEFAULT_PER_PAGE

    @user = current_user
    @submissions = Submission.approved.page(page).per(per_page)
  end

  # POST /submissions
  def create
    if params[:photo].blank?
      render json: { error: 'missing photo' }, status: :unprocessable_entity
      return
    end

    submission = Submission.new
    submission.title = params[:title]
    submission.artist = params[:artist]
    submission.location_note = params[:location_note]
    submission.latitude = params[:latitude]
    submission.longitude = params[:longitude]
    submission.status = PROCESSING
    submission.user = current_user

    if submission.save
      SubmissionWorker.perform_async(submission.id, params[:photo])
      render json: { success: true }, status: :accepted
    else
      render json: submission.errors, status: :unprocessable_entity
    end
  end

  # GET submissions/mine
  def mine
    @submissions = current_user.submissions.order(created_at: :desc)
    render 'index.json'
  end

  # GET submissions/favorites
  def favorites
    @submissions = current_user.favorite_submissions.order(created_at: :desc)
    render 'index.json'
  end

  # POST /submissions/:id/favorite
  def favorite
    user = current_user
    submission = Submission.find(params[:id])
    user.favorite!(submission)
  end

  # DELETE /submissions/:id/unfavorite
  def unfavorite
    user = current_user
    submission = Submission.find(params[:id])
    user.unfavorite!(submission)
  end
    
end