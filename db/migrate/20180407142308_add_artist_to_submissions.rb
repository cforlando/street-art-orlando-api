class AddArtistToSubmissions < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :artist, :string, index: true
  end
end
