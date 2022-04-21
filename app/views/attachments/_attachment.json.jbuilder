json.extract! attachment, :id, :name, :attached_by_id, :approval_status, :approved_by_id, :company_id, :project_id, :phase_id, :step_id, :created_at, :updated_at
json.url attachment_url(attachment, format: :json)
