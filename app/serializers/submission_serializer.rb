class SubmissionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :photo_url, :thumb_url, :tiny_url, :created_at, :updated_at
end
