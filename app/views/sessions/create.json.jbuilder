if @error.nil?
  json.token @token.to_s
  json.user do
    json.extract!(@user, :email)
  end
else
  json.error @error
end
