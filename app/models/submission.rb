class Submission < ApplicationRecord
  belongs_to :user
  mount_base64_uploader :photo, PhotoUploader
end
