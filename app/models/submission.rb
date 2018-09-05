class Submission < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  belongs_to :user

  mount_base64_uploader :photo, PhotoUploader

  after_create_commit :send_welcome_email
  after_update_commit :send_status_email

  validates :user, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  validates :rejected_reason, presence: true, if: :first_rejected?

  scope :pending, -> { where(status: 'pending').order(created_at: :desc) }
  scope :approved, -> { where(status: 'approved').order(created_at: :desc) }
  scope :rejected, -> { where(status: 'rejected').order(created_at: :desc) }

  def coordinate
    [latitude, longitude]
  end

  def photo_url
    photo.display.url
  end

  def thumb_url
    photo.thumb.url
  end

  def tiny_url
    photo.tiny.url
  end

  protected

  def first_rejected?
    self.status_email_sent_at.blank? && status == 'rejected'
  end

  def send_welcome_email
    SubmissionsMailer.admin_report_email(id).deliver_later
    SubmissionsMailer.pending_email(id).deliver_later
  end

  def send_status_email
    if ['rejected', 'approved'].include?(status) && status_email_sent_at.blank?
      SubmissionsMailer.status_email(id).deliver_later
    end
  end
  
end
