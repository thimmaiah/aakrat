json.extract! phase, :id, :name, :start_date, :end_date, :status, :project_id, :assigned_to_id, :visible_to_client, :payment_status, :percentage_complete, :completed, :created_at, :updated_at
json.url phase_url(phase, format: :json)
