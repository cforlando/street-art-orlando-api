class Api::SubmissionsController < Api::BaseController
  before_action :set_submission, only: [:show, :update, :destroy]

  # GET /submissions
  def index
    page = params[:page] || 1

    @submissions = Submission.page(page)
    per_page = Submission.page(page).per_page
    total_pages = Submission.page(page).total_pages

    render json: { total: total_pages, per_page: per_page, submissions: @submissions }
  end

  # GET /submissions/1
  def show
    render json: @submissions
  end

  # POST /submissions
  def create
    @submission = Submission.new(submission_params)

    if @submission.save
      render json: @submission, status: :created, location: @submission
    else
      render json: @submission.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /submissions/1
  def update
    if @submission.update(submission_params)
      render json: @submission
    else
      render json: @submission.errors, status: :unprocessable_entity
    end
  end

  # DELETE /submissions/1
  def destroy
    @submission.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def submission_params
      params.require(:submission).permit(:title, :description)
    end
    
end