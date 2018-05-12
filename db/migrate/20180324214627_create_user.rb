class CreateUser < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false
      t.string :password_digest, null: false
      
      # Reset
      t.string :reset_password_token
      t.datetime :reset_password_token_sent_at

      t.boolean :vip, default: false

      t.timestamps
    end
  end
end
