class SubmissionWorker
  include Sidekiq::Worker

  def perform(submission_id, photo_str)
    submission = Submission.find(submission_id)
    submission.photo = photo_str
    submission.save!
  end

end
