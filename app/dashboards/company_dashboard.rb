require "administrate/base_dashboard"

class CompanyDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    versions: Field::HasMany,
    users: Field::HasMany,
    projects: Field::HasMany,
    clients: Field::HasMany,
    attachments: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    url: Field::String,
    category: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    logo_url: Field::Text,
    active: Field::Boolean,
    company_type: Field::String,
    created_by: Field::Number,
    deleted_at: Field::DateTime,
    parent_company_id: Field::Number,
    currency: Field::String,
    units: Field::String,
    trial_end_date: Field::Date,
    trial: Field::Boolean,
    address: Field::Text,
    gst_number: Field::String,
    entity_names: Field::Text
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    name
    url
    category
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    name
    url
    category
    created_at
    updated_at
    logo_url
    active
    company_type
    created_by
    deleted_at
    parent_company_id
    currency
    units
    trial_end_date
    trial
    address
    gst_number
    
    users
    projects
    clients
    attachments

  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    versions
    
    users
    projects
    clients
    attachments
    name
    url
    category
    logo_url
    active
    company_type
    created_by
    deleted_at
    parent_company_id
    currency
    units
    trial_end_date
    trial
    address
    gst_number
    entity_names
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

  # Overwrite this method to customize how companies are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(company)
    company.name
  end
end
