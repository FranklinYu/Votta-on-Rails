if user.nil?
  json.creator nil
else
  json.creator do
    json.id user.id
    json.name user.email
  end
end
