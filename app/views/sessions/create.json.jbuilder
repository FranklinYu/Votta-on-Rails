if @error.nil?
  json.token @token
else
  json.error @error
end
