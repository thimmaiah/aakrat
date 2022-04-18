json.extract! payment, :id, :company_id, :amount, :plan, :discount, :reference_number, :user_id, :created_at, :updated_at
json.url payment_url(payment, format: :json)
