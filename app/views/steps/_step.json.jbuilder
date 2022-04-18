json.extract! step, :id, :name, :start_date, :end_date, :status, :project_id, :phase_id, :assigned_to_id, :visible_to_client, :completed, :created_at, :updated_at
json.url step_url(step, format: :json)
