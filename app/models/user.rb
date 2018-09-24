class User < ApplicationRecord
  has_secure_password

  has_many :favorites, dependent: :destroy
  has_many :submissions, dependent: :restrict_with_error
  has_many :favorite_submissions, -> { order('favorites.created_at DESC')}, through: :favorites, source: :submission

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :username, presence: true
  validates :username, uniqueness: true

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  def active?
    self.disabled.present? && !self.disabled
  end

  def first_name
    self.name.present? ? self.name.split(' ').first : nil
  end

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

  def generate_password_token!
    if should_update_password_token?
      self.reset_password_token = generate_token
      self.reset_password_token_sent_at = Time.now.utc
      save!
    end
  end

  def should_update_password_token?
    if self.reset_password_token_sent_at.present?
      return (self.reset_password_token_sent_at + 5.hours) < Time.now.utc
    end
    true
  end

  def password_token_valid?
    if self.reset_password_token_sent_at.present?
      return (self.reset_password_token_sent_at + 6.hours) > Time.now.utc
    end
    false
  end

  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save
  end

  private

  def generate_token
    rand.to_s[2..7]
  end

end
