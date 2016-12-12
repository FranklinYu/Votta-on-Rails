json.extract! candidate, :id, :body, :topic_id, :created_at, :updated_at
json.partial! 'user', locals: {user: candidate.user}
