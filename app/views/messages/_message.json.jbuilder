json.extract! message, :id, :nom, :structure, :email, :téléphone, :message, :created_at, :updated_at
json.url message_url(message, format: :json)
