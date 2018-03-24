class User < ApplicationRecord
  has_secure_password
  has_many :submissions

  validates :email, :password, presence: true
  validates :email, uniqueness: true
  validates :password, confirmation: true

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
end
