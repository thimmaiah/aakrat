json.extract! client, :id, :first_name, :last_name, :email, :phone, :user_type,
              :user_id, :company_id, :full_name

json.value client.full_name
json.url client_url(client, format: :json)
