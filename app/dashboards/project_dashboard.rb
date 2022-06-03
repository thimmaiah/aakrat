require "administrate/base_dashboard"

class ProjectDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    roles: Field::HasMany,
    company: Field::BelongsTo,
    client: Field::BelongsTo,
    team_lead: Field::BelongsTo,
    site_visits: Field::HasMany,
    phases: Field::HasMany,
    payments: Field::HasMany,
    project_accesses: Field::HasMany,
    attachments: Field::HasMany,
    notes: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    start_date: Field::Date,
    end_date: Field::Date,
    cost_estimate_cents: Field::String.with_options(searchable: false),
    percentage_completed: Field::Number,
    status: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    currency: Field::String,
    total_days: Field::Number,
    completed_days: Field::Number,
    payment_amount_cents: Field::String.with_options(searchable: false),
    cloned_from: Field::Number,
    client_estimated_budget_cents: Field::String.with_options(searchable: false),
    actual_cost_cents: Field::String.with_options(searchable: false),
    estimated_builtup_area: Field::Number,
    actual_builtup_area: Field::Number,
    fees_cents: Field::String.with_options(searchable: false),
    percentage_of_estimated_budget: Field::String.with_options(searchable: false),
    per_sq_ft_rate_cents: Field::String.with_options(searchable: false),
    fee_type: Field::String,
    project_type: Field::String,
    scale: Field::String,
    style: Field::String,
    pattern: Field::String,
    services: Field::Text,
    address: Field::Text,
    discount: Field::String.with_options(searchable: false),
    entity_name: Field::String
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    name
    status
    percentage_completed
    project_type
    pattern
    style
    services
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[

    id
    name
    start_date
    end_date
    cost_estimate_cents
    percentage_completed
    status
    created_at
    updated_at
    currency
    total_days
    completed_days
    payment_amount_cents
    cloned_from
    client_estimated_budget_cents
    actual_cost_cents
    estimated_builtup_area
    actual_builtup_area
    fees_cents
    percentage_of_estimated_budget
    per_sq_ft_rate_cents
    fee_type
    project_type
    scale
    style
    pattern
    services
    address
    discount
    entity_name

    company
    client
    team_lead
    site_visits
    phases
    payments
    project_accesses
    attachments
    notes

  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    name
    start_date
    end_date
    cost_estimate_cents
    percentage_completed
    status
    currency
    total_days
    completed_days
    payment_amount_cents
    cloned_from
    client_estimated_budget_cents
    actual_cost_cents
    estimated_builtup_area
    actual_builtup_area
    fees_cents
    percentage_of_estimated_budget
    per_sq_ft_rate_cents
    fee_type
    project_type
    scale
    style
    pattern
    services
    address
    discount
    entity_name
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

  # Overwrite this method to customize how projects are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(project)
    project.name
  end
end
