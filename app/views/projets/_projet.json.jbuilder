json.extract! projet, :id, :titre, :chapeau, :thème, :workflow_state, :slug, :created_at, :updated_at
json.url projet_url(projet, format: :json)
