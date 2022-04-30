json.extract! user, :id, :first_name, :last_name, :full_name, :roles
json.url user_url(user, format: :json)
