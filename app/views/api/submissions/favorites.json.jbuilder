json.submissions @submissions do |submission|
  json.(
    submission,
    :id,
    :title,
    :description,
    :photo_url,
    :thumb_url,
    :tiny_url,
    :artist,
    :location_note,
    :created_at
  )
  json.latitude submission.latitude.to_f
  json.longitude submission.longitude.to_f
end
