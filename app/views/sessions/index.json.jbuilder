json.sessions do
  json.array!(@sessions, :id, :comment, :created_at)
end
