if @error.nil?
  json.token @token.to_s
  json.user do
    json.extract!(@user, :email)
  end
  json.id @session_id
else
  json.error @error
end
