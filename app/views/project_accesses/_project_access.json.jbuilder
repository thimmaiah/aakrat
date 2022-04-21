json.extract! project_access, :id, :company_id, :user_id, :project_id,
              :role_name, :created_at, :updated_at
json.url project_access_url(project_access, format: :json)
