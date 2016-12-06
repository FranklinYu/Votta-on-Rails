if @error.nil?
  json.token @token.to_s
else
  json.error @error
end
