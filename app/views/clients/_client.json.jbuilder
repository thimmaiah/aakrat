json.extract! client, :id, :first_name, :last_name, :email, :phone, :user_type,
              :user_id, :company_id, :created_at, :updated_at
json.url client_url(client, format: :json)
