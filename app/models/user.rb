class User < ApplicationRecord
  has_secure_password validations: false

  has_many :favorites, dependent: :destroy
  has_many :submissions, dependent: :restrict_with_error
  has_many :favorite_submissions, -> { order('favorites.created_at DESC')}, through: :favorites, source: :submission

  validates :email, presence: true
  validates :email, uniqueness: true

  validates :password, presence: true,
                       confirmation: true,
                       length: { within: 6..40 },
                       on: :create

  validates :password, confirmation: true,
                       length: { within: 6..40 },
                       allow_blank: true,
                       on: :update

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  def favorite!(submission)
    self.favorites.create!(submission_id: submission.id)
  end

  def unfavorite!(submission)
    favorite = self.favorites.find_by(submission_id: submission.id)
    favorite.destroy!
  end

  def favorite?(submission)
    self.favorites.find_by(submission_id: submission.id).present?
  end

end
