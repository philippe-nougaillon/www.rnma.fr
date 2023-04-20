json.extract! ressource, :id, :titre, :chapeau, :slug, :workflow_state, :created_at, :updated_at
json.url ressource_url(ressource, format: :json)
