require "administrate/base_dashboard"

class StepDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    project: Field::BelongsTo,
    company: Field::BelongsTo,
    phase: Field::BelongsTo,
    assigned_to: Field::BelongsTo,
    client_attachments: Field::HasMany,
    notes: Field::HasMany,

    id: Field::Number,
    name: Field::String,
    start_date: Field::Date,
    end_date: Field::Date,
    status: Field::String,
    visible_to_client: Field::Boolean,
    completed: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    days: Field::Number,
    approval_status: Field::String
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    project
    company
    phase
    name
    start_date
    status
    assigned_to
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    name
    start_date
    end_date
    status
    visible_to_client
    completed
    created_at
    updated_at
    days
    approval_status

    project
    company
    phase
    assigned_to
    client_attachments
    notes

  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    name
    start_date
    end_date
    status
    visible_to_client
    completed
    days
    approval_status
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how steps are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(step)
    step.name
  end
end
