class Submission < ApplicationRecord
  belongs_to :user
  mount_base64_uploader :photo, PhotoUploader

  validates :title, presence: true
  validates :user, presence: true
  validates :photo, presence: true

  scope :pending, -> { where(status: 'pending').order(created_at: :desc) }
  scope :approved, -> { where(status: 'approved').order(created_at: :desc) }
  scope :rejected, -> { where(status: 'rejected').order(created_at: :desc) }

  def photo_url
    photo.url
  end

  def thumb_url
    photo.thumb.url
  end

  def tiny_url
    photo.tiny.url
  end
  
end
