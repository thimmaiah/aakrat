json.extract! project, :id, :name, :start_date, :end_date, :percentage_completed, :status, :company_id, :created_at, :updated_at
json.url project_url(project, format: :json)
