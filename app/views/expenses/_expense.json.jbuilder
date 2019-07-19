json.extract! expense, :id, :amount, :user_id, :assignment, :created_at, :updated_at
json.url user_expenses_url(@user, @expense, format: :json)
