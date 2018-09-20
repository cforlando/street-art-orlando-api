class UpdateCoordinateScaleToSubmissions < ActiveRecord::Migration[5.1]
  def up
    change_column :submissions, :latitude, :decimal, precision: 15, scale: 10
    change_column :submissions, :longitude, :decimal, precision: 15, scale: 10
  end
  
  def down
    change_column :submissions, :latitude, :decimal, precision: 10, scale: 6
    change_column :submissions, :longitude, :decimal, precision: 10, scale: 6
  end
end
