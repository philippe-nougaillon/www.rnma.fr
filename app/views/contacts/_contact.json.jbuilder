json.extract! contact, :id, :maison_id, :nom, :prénom, :fonction, :téléphone, :email, :created_at, :updated_at
json.url contact_url(contact, format: :json)
