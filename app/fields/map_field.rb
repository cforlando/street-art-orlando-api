require "administrate/field/base"

class MapField < Administrate::Field::Base
  
  def map_url
    lat = data[0]
    lon = data[1]
    parameters = "markers=color:red|#{lat},#{lon}&size=640x400&zoom=17&key=#{ENV['GOOGLE_MAPS_API_KEY']}"
    "https://maps.googleapis.com/maps/api/staticmap?#{parameters}"
  end

end
