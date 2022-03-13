json.extract! transaction, :id, :recurrence_id, :title, :price_cents, :date, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
