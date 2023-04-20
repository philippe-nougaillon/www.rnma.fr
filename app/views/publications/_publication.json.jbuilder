json.extract! publication, :id, :titre, :chapeau, :contenu, :lien, :created_at, :updated_at
json.url publication_url(publication, format: :json)
