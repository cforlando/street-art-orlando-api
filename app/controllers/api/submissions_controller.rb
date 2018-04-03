class Api::SubmissionsController < Api::BaseController

  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 10

  # GET /submissions
  def index
    page = params[:page] || DEFAULT_PAGE
    per_page = params[:per_page] || DEFAULT_PER_PAGE

    submissions = Submission.all.order(created_at: :desc).page(page).per(per_page)
    meta = {
      current_page: submissions.current_page,
      next_page: submissions.next_page,
      total: submissions.total_count,
      total_pages: submissions.total_pages
    }

    submissions_array = submissions.map do |s|
      {
        id: s.id,
        title: s.title,
        description: s.description,
        photo_url: s.photo_url,
        thumb_url: s.thumb_url,
        tiny_url: s.tiny_url,
        latitude: s.latitude.present? ? s.latitude.to_f : nil,
        longitude: s.longitude.present? ? s.longitude.to_f : nil,
        created_at: s.created_at,
        updated_at: s.updated_at
      }
    end

    render json: { submissions: submissions_array, meta: meta }
  end

  # POST /submissions
  def create
    submission = Submission.new
    submission.title = params[:title]
    submission.photo = params[:photo]
    submission.latitude = params[:latitude]
    submission.longitude = params[:longitude]
    submission.user = current_user

    if submission.save
      render json: submission, status: :created
    else
      render json: submission.errors, status: :unprocessable_entity
    end
  end
    
end