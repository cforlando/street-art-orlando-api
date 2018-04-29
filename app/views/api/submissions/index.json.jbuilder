json.submissions @submissions do |submission|
  json.(
    submission,
    :id,
    :status,
    :title,
    :description,
    :photo_url,
    :thumb_url,
    :tiny_url,
    :artist,
    :location_note,
    :created_at
  )

  json.favorite @user.present? ? @user.favorite?(submission) : false
  json.latitude submission.latitude.to_f
  json.longitude submission.longitude.to_f
end

json.meta do
  json.current_page @submissions.current_page
  json.next_page @submissions.next_page
  json.total @submissions.total_count
  json.total_pages @submissions.total_pages
end if @submissions.total_pages.present?
