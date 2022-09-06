json.extract! transaction, :id, :price, :volume, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
