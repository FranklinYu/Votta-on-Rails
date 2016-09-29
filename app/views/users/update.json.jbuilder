if @error.nil?
  json.(@user, :email)
  json.password_updated @password_updated
else
  json.error @error
end
