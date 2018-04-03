class AddCoordinateToSubmissions < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :latitude, :decimal, precision: 10, scale: 6
    add_column :submissions, :longitude, :decimal, precision: 10, scale: 6
  end
end
