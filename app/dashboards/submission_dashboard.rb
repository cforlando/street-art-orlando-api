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
    photo: Field::Carrierwave.with_options(
      image: :thumb,
      multiple: false,
      image_on_index: true,
      remove: false,
      remote_url: false
    ),
    status: Field::Select.with_options(collection: ['pending', 'approved', 'processing', 'rejected']),
    rejected_reason: Field::String.with_options(searchable: false),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    status_email_sent_at: Field::DateTime,
    latitude: Field::String.with_options(searchable: false),
    longitude: Field::String.with_options(searchable: false),
    artist: Field::String,
    ip_address: Field::String,
    app_version: Field::String,
    device_model: Field::String,
    system_version: Field::String,
    device_locale: Field::String,
    location_note: Field::Text,
    coordinate: MapField,
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
    :rejected_reason,
    :title,
    :artist,
    :description,
    :photo,
    :coordinate,
    :location_note,
    :created_at,
    :updated_at,
    :status_email_sent_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :user,
    :status,
    :rejected_reason,
    :photo,
    :title,
    :artist,
    :description,
    :latitude,
    :longitude,
    :location_note
  ].freeze

  # Overwrite this method to customize how submissions are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(submission)
  #   "Submission ##{submission.id}"
  # end
end
