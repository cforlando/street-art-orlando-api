class Report < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :submission

  validates :submission, presence: true
  validates :reason, presence: { message: 'missing report code' }
  
  validates :status, :inclusion => { :in => %w(pending ignored moderated), :message => "%{value} is not a valid status" }
end