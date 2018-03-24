class CreateSubmission < ActiveRecord::Migration[5.1]
  def change
    create_table :submissions do |t|
      t.string :title
      t.text :description
      t.string :photo
      t.string :status, default: 'pending', index: true
      
      t.references :user, index: true
      t.timestamps
    end
  end
end
