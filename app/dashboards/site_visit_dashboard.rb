require "administrate/base_dashboard"

class SiteVisitDashboard < Administrate::BaseDashboard
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
    id: Field::Number,
    cost_cents: Field::String.with_options(searchable: false),
    scheduled_on: Field::Date,
    conducted_on: Field::Date,
    completed: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
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
    scheduled_on
    completed
    conducted_on
    assigned_to
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    cost_cents
    scheduled_on
    conducted_on
    completed
    created_at
    updated_at
    assigned_to
    project
    company
    phase

  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    cost_cents
    scheduled_on
    conducted_on
    completed
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

  # Overwrite this method to customize how site visits are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(site_visit)
    "#{site_visit.project.name} #{site_visit.scheduled_on}"
  end
end
