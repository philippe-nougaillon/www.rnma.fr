json.extract! maison, :id, :nom, :adresse, :cp, :ville, :téléphone, :email, :site, :latitude, :longitude, :slug, :created_at, :updated_at
json.url maison_url(maison, format: :json)
