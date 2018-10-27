class SubmissionWorker
  include Sidekiq::Worker

  def perform(submission_id, photo_str)
    submission = Submission.find(submission_id)
    user = submission.user

    submission.photo = photo_str
    submission.status = user.active? && user.vip? ? 'approved' : 'pending'
    submission.save!
  end

end
