json.extract! site_visit, :id, :project_id, :company_id, :phase_id, :cost_cents, :scheduled_on, :conducted_on, :assigned_to_id, :completed, :created_at, :updated_at
json.url site_visit_url(site_visit, format: :json)
