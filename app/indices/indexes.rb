ThinkingSphinx::Index.define :company, with: :real_time do
  # fields
  indexes name, sortable: true
  indexes category, sortable: true

  # attributes
  has company_type, type: :string
  has created_at, type: :timestamp
  has active, type: :boolean
end

ThinkingSphinx::Index.define :user, with: :real_time do
  # fields
  indexes first_name, sortable: true
  indexes last_name, sortable: true
  indexes email

  # attributes
  has role, type: :string
  has created_at, type: :timestamp
  has active, type: :boolean
  has company_id, type: :integer
end

ThinkingSphinx::Index.define :client, with: :real_time do
  # fields
  indexes first_name, sortable: true
  indexes last_name, sortable: true
  indexes email
  indexes user_type

  # attributes
  has company_id, type: :integer
end
