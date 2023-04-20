json.extract! cotisation, :id, :adhesion_id, :période, :montant, :date_échéance, :workflow_state, :mémo, :created_at, :updated_at
json.url cotisation_url(cotisation, format: :json)
