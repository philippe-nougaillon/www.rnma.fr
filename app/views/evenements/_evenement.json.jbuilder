json.extract! evenement, :id, :debut, :fin, :lieu, :titre, :chapeau, :created_at, :updated_at
json.url evenement_url(evenement, format: :json)
