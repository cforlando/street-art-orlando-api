class AddLocationNoteToSubmission < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :location_note, :text
  end
end
