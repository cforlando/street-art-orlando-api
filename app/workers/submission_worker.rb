class SubmissionWorker
  include Sidekiq::Worker

  def perform(submission_id, photo_str)
    user = submission.user

    submission = Submission.find(submission_id)
    submission.photo = photo_str
    submission.status = user.active? && user.vip? ? 'approved' : 'pending'
    submission.save!
  end

end
