json.extract! candidate, :id, :body, :topic_id, :user_id, :created_at, :updated_at
json.url candidate_url(candidate, format: :json)