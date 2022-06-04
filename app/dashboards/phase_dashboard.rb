require "administrate/base_dashboard"

class PhaseDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    company: Field::BelongsTo,
    project: Field::BelongsTo,
    assigned_to: Field::BelongsTo,
    notes: Field::HasMany,
    site_visits: Field::HasMany,
    steps: Field::HasMany,
    payments: Field::HasMany,
    attachments: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    start_date: Field::Date,
    end_date: Field::Date,
    status: Field::String,
    visible_to_client: Field::Boolean,
    payment_status: Field::String,
    percentage_complete: Field::Number,
    completed: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    total_days: Field::Number,
    completed_days: Field::Number,
    payment_required: Field::Boolean,
    payment_amount_cents: Field::String.with_options(searchable: false),
    days: Field::Number,
    payment_due_percentage: Field::Number,
    payment_due_cents: Field::String.with_options(searchable: false)
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    company
    project
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
    payment_status
    percentage_complete
    completed
    created_at
    updated_at
    total_days
    completed_days
    payment_required
    payment_amount_cents
    days
    payment_due_percentage
    payment_due_cents

    company
    project
    assigned_to
    notes
    site_visits
    steps
    payments
    attachments

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
    payment_status
    percentage_complete
    completed
    total_days
    completed_days
    payment_required
    payment_amount_cents
    days
    payment_due_percentage
    payment_due_cents
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

  # Overwrite this method to customize how phases are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(phase)
    phase.name
  end
end
