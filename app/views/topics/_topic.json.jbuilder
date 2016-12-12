json.extract! topic, :id, :title, :body, :created_at, :updated_at
json.partial! 'user', locals: {user: topic.user}
