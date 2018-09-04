class AddRejectionReasonToSubmissions < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :rejected_reason, :string
    add_column :submissions, :status_email_sent_at, :datetime
  end
end
