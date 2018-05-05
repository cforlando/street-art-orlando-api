class CreateSubmission < ActiveRecord::Migration[5.1]
  def change
    create_table :submissions do |t|
      t.string :title
      t.string :artist, index: true
      t.text :description
      t.string :photo
      t.string :status, default: 'processing', index: true

      # Location
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.text :location_note

      # Device
      t.string :ip_address
      t.string :app_version
      t.string :device_model
      t.string :system_version
      t.string :device_locale
      
      t.references :user, index: true
      t.timestamps
    end
  end
end
