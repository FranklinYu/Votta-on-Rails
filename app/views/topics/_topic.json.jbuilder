json.extract! topic, :id, :title, :body, :user_id, :created_at, :updated_at
if topic.user.nil?
  json.creator nil
else
  json.creator do
    json.id topic.user_id
    json.name topic.user.email
  end
end
