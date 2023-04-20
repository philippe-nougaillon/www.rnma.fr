json.extract! post, :id, :titre, :chapeau, :workflow_state, :created_at, :updated_at
json.url post_url(post, format: :json)
