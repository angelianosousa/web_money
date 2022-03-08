json.extract! recurrence, :id, :user_profile_id, :category_id, :title, :price_cents, :date_expire, :created_at, :updated_at
json.url recurrence_url(recurrence, format: :json)
