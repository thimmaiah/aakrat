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

ThinkingSphinx::Index.define :project, with: :real_time do
  # fields
  indexes name
  indexes client.full_name
  indexes project_type
  indexes scale
  indexes style
  indexes pattern
  indexes services
  indexes fee_type
  indexes status
  indexes start_date
  indexes end_date
  # attributes
  has company_id, type: :integer
end

ThinkingSphinx::Index.define :phase, with: :real_time do
  # fields
  indexes name
  indexes project.name
  indexes status
  indexes payment_status
  indexes payment_required
  indexes start_date
  indexes end_date
  indexes assigned_to.full_name
  # attributes
  has company_id, type: :integer
  has assigned_to_id, type: :integer
  has completed, type: :boolean
  has visible, type: :boolean
end

ThinkingSphinx::Index.define :step, with: :real_time do
  # fields
  indexes name
  indexes project.name
  indexes phase.name
  indexes status
  indexes start_date
  indexes end_date
  indexes assigned_to.full_name
  # attributes
  has company_id, type: :integer
  has assigned_to_id, type: :integer
  has completed, type: :boolean
  has visible, type: :boolean
end

ThinkingSphinx::Index.define :site_visit, with: :real_time do
  # fields
  indexes project.name
  indexes phase.name
  indexes scheduled_on
  indexes conducted_on
  indexes assigned_to.full_name
  # attributes
  has company_id, type: :integer
  has assigned_to_id, type: :integer
  has completed, type: :boolean
end
