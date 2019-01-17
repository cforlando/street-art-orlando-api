class CreateReport < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.references :submission, index: true
      t.references :user, index: true

      t.string :status, default: 'pending', index: true
      t.text :reason
      t.text :moderation_note

      # Device
      t.string :ip_address
      t.string :device_identifier, index: true

      t.timestamps
    end
  end
end
