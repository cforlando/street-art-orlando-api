class User < ApplicationRecord
  has_secure_password validations: false
  has_many :submissions, dependent: :restrict_with_error

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
  
end
