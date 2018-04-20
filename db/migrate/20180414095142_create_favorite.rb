class CreateFavorite < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.references :user, index: true
      t.references :submission, index: true
      t.timestamps
    end
  end
end
