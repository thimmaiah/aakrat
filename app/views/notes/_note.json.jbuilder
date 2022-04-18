json.extract! note, :id, :user_id, :company_id, :owner_id, :owner_type, :created_at, :updated_at
json.url note_url(note, format: :json)
