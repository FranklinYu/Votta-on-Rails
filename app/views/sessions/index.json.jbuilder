json.sessions do
  json.array!(@sessions, :id, :comment)
end
