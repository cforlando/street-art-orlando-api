require "administrate/base_dashboard"

class SubmissionDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    id: Field::Number,
    title: Field::String,
    description: Field::Text,
    photo: PhotoField,
    status: Field::Select.with_options(collection: ['pending', 'approved', 'rejected']),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    latitude: Field::String.with_options(searchable: false),
    longitude: Field::String.with_options(searchable: false),
    artist: Field::String,
    ip_address: Field::String,
    app_version: Field::String,
    device_model: Field::String,
    system_version: Field::String,
    device_locale: Field::String,
    location_note: Field::Text,
    coordinate: MapField
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :photo,
    :status,
    :user
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :user,
    :id,
    :status,
    :photo,
    :coordinate,
    :location_note,
    :artist,
    :title,
    :description,
    :created_at,
    :updated_at,
    :ip_address
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :user,
    :status,
    :latitude,
    :longitude,
    :location_note,
    :artist,
    :title,
    :description,
  ].freeze

  # Overwrite this method to customize how submissions are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(submission)
  #   "Submission ##{submission.id}"
  # end
end