class AddRejectionReasonToSubmissions < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :rejected_reason, :string
    add_column :submissions, :status_email_sent_at, :datetime
  end

  def up
    add_column :submissions, :rejected_reason, :string
    add_column :submissions, :status_email_sent_at, :datetime
  end

  def down
    remove_column :submissions, :rejected_reason
    remove_column :submissions, :status_email_sent_at
  end
end
