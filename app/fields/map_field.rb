require "administrate/field/base"

class MapField < Administrate::Field::Base

  def map_latitude
    data[0]
  end

  def map_longitude
    data[1]
  end

end
