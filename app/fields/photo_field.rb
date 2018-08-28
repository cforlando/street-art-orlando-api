require "administrate/field/base"

class PhotoField < Administrate::Field::Base
  
  def photo_url
    data.present? ? data.thumb.url : ""
  end

  def tiny_url
    data.present? ? data.tiny.url : ""
  end

end
