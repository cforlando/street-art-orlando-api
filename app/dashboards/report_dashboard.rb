require "administrate/base_dashboard"

class ReportDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    submission: Field::BelongsTo,
    id: Field::Number,
    status: Field::Select.with_options(collection: ['pending', 'ignored', 'moderated']),
    reason: Field::String,
    moderation_note: Field::Text,
    ip_address: Field::String,
    device_identifier: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :submission,
    :user,
    :status,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :user,
    :submission,
    :id,
    :status,
    :reason,
    :moderation_note,
    :ip_address,
    :device_identifier,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :status,
    :moderation_note
  ].freeze

  # Overwrite this method to customize how reports are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(report)
  #   "Report ##{report.id}"
  # end
end
